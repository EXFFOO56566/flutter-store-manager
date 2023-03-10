// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:provider/provider.dart';

// Repository packages
import 'package:authentication_repository/authentication_repository.dart';
import 'package:user_repository/user_repository.dart';

// Bloc
import 'package:flutter_store_manager/settings/cubit/settings_cubit.dart';
import 'package:flutter_store_manager/tabs/cubit/tabs_cubit.dart';
import 'authentication/bloc/authentication_bloc.dart';

// Models
import 'package:flutter_store_manager/settings/models/models.dart';

// View
import 'package:flutter_store_manager/routes.dart';

//Themes
import 'package:flutter_store_manager/themes.dart';

// Constants
import 'package:flutter_store_manager/constants/languages.dart';
import 'constants/strings.dart';

// Stores
import 'stores/stores.dart';

class App extends StatefulWidget {
  final SimpleStore simpleStore;
  final HttpClient httpClient;

  const App({Key? key, required this.simpleStore, required this.httpClient}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late AuthenticationRepository _authenticationRepository;
  late UserRepository _userRepository;

  @override
  void initState() {
    _authenticationRepository = AuthenticationRepository(widget.httpClient);
    _userRepository = UserRepository();
    super.initState();
  }

  @override
  void dispose() {
    _authenticationRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SimpleStore>(create: (_) => widget.simpleStore),
        Provider<HttpClient>(create: (_) => widget.httpClient),
      ],
      child: AppProvider(
        authenticationRepository: _authenticationRepository,
        userRepository: _userRepository,
      ),
    );
  }
}

class AppProvider extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  const AppProvider({Key? key, required this.authenticationRepository, required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(
          create: (context) => authenticationRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<GlobalBloc>(create: (_) => GlobalBloc()),
          BlocProvider<AuthenticationBloc>(
            create: (_) => AuthenticationBloc(
              authenticationRepository: authenticationRepository,
              userRepository: userRepository,
            ),
          ),
          BlocProvider<SettingsCubit>(
            create: (_) => SettingsCubit(),
          ),
          BlocProvider<TabsCubit>(
            create: (_) => TabsCubit(),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, Setting>(
      builder: (context, settings) {
        SystemUiOverlayStyle style = settings.brightness == Brightness.dark
            ? SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent)
            : SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent);
        ThemeData theme = getCustomThemeData(brightness: settings.brightness);

        SystemChrome.setSystemUIOverlayStyle(theme.appBarTheme.systemOverlayStyle ?? style);

        return MaterialApp(
          navigatorObservers: <NavigatorObserver>[observer],
          theme: theme,
          initialRoute: '/',
          title: Strings.appTitle,
          routes: Routes.routes(),
          onGenerateRoute: (settings) => Routes.onGenerateRoute(settings),
          locale: _getLocate(supportedLocales[settings.locate]),
          supportedLocales: supportedLocales.entries.map((entry) => _getLocate(entry.value)),
          localizationsDelegates: const [
            // A class which loads the translations from JSON files
            AppLocalizations.delegate,
            // Built-in localization of basic text for Material widgets
            GlobalMaterialLocalizations.delegate,
            // Built-in localization for text direction LTR/RTL
            GlobalWidgetsLocalizations.delegate,

            GlobalCupertinoLocalizations.delegate,
          ],
          // Returns a locale which will be used by the app
          localeResolutionCallback: (locale, supportedLocales) =>
              // Check if the current device locale is supported
              supportedLocales.firstWhere((supportedLocale) => supportedLocale.languageCode == locale?.languageCode,
                  orElse: () => supportedLocales.first),
        );
      },
    );
  }
}

Locale _getLocate(Map<String, dynamic>? configs) {
  if (configs == null) {
    return const Locale('en', 'US');
  }

  if (configs['scriptCode'] != null) {
    return Locale.fromSubtags(
      languageCode: configs['languageCode'],
      scriptCode: configs['scriptCode'],
      countryCode: configs['countryCode'],
    );
  }
  return Locale(configs['languageCode'], configs['countryCode'] ?? '');
}
