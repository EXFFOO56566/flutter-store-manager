import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/ui.dart';

import 'blocs/blocs.dart';
import 'routes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => AuthCubit(),
        ),
        BlocProvider<SettingCubit>(
          create: (_) => SettingCubit(),
        ),
        BlocProvider<TabBarCubit>(
          create: (_) => TabBarCubit(),
        ),
        BlocProvider<ReportCubit>(
          create: (_) => ReportCubit(),
        ),
      ],
      child: _AppPage(),
    );
  }
}

class _AppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingCubit, SettingState>(
      builder: (context, state) {
        return MaterialApp(
          initialRoute: '/',
          title: 'Store Manager',
          theme: getCustomThemeData(brightness: state.brightness),
          routes: Routes.routes(),
          // home: Test(),
        );
      },
    );
  }
}
