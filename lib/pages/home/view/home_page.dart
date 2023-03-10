// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:appcheap_flutter_core/service/messaging.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:community_material_icon/community_material_icon.dart';

// Repository packages
import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_message_repository/firebase_message_repository.dart';
import 'package:flutter_store_manager/utils/auth.dart';
import 'package:google_place_repository/google_place_repository.dart';
import 'package:store_setting_repository/store_setting_repository.dart';

// Bloc
import 'package:flutter_store_manager/authentication/authentication.dart';
import 'package:flutter_store_manager/pages/store_setting/bloc/store_setting_bloc.dart';
import 'package:flutter_store_manager/settings/settings.dart';
import 'package:flutter_store_manager/stores/global/bloc/global_bloc.dart';

// View
import 'package:flutter_store_manager/pages/chats/chats.dart';
import 'package:flutter_store_manager/pages/home/view/home_tab.dart';
import 'package:flutter_store_manager/pages/home/view/non_vendor.dart';
import 'package:flutter_store_manager/pages/on_boarding/on_boarding.dart';
import 'package:flutter_store_manager/pages/orders/orders.dart';
import 'package:flutter_store_manager/pages/pages.dart';
import 'package:flutter_store_manager/pages/products/products.dart';
import 'package:flutter_store_manager/pages/profile/view/view.dart';
import 'package:flutter_store_manager/pages/store_setting/view/multi_store_setup_register/view/store_setup_page.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter_store_manager/tabs/tabs.dart';

// Constants
import 'package:flutter_store_manager/constants/constants.dart';
import 'package:flutter_store_manager/constants/credentials.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseMessageRepository firebaseMessageRepository = FirebaseMessageRepository(context.read<HttpClient>());

    return BlocBuilder<SettingsCubit, Setting>(
      builder: (_, stateSetting) {
        if (stateSetting.enableOnBoarding) {
          return const OnBoardingPage();
        }
        return BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (_, state) {
            if (state.status == AuthenticationStatus.authenticated) {
              setUserToken(token: state.token);
              setUserId(id: state.user.id);
              updateTokenToDatabase(
                () async {
                  try {
                    String? token = await getToken();
                    Map<String, dynamic> data = {'token': token};
                    await firebaseMessageRepository.updateUserToken(
                        requestData: RequestData(
                      data: data,
                      query: {'app-builder-decode': true},
                      token: state.token,
                    ));
                  } catch (e) {
                    rethrow;
                  }
                },
              );
            } else {
              removeTokenInDatabase(() async {
                try {
                  String? token = await getToken();
                  Map<String, dynamic> data = {'token': token, 'user_id': userId};
                  await firebaseMessageRepository.removeUserToken(
                      requestData: RequestData(
                    data: data,
                    query: {'app-builder-decode': true},
                    token: userToken,
                  ));
                } on RequestError catch (_) {
                  rethrow;
                }
              });
            }
          },
          builder: (context, state) {
            if (state.status == AuthenticationStatus.authenticated) {
              if (!checkRoleUserVendor(state.user)) {
                return const NonVendor();
              }
              if (state.isNewVendor) {
                if (state.skipMultiStep) {
                  return HomeTabs(
                    firebaseMessageRepository: firebaseMessageRepository,
                  );
                }
                return BlocProvider(
                  create: (context) {
                    return StoreSettingBloc(
                        storeSettingRepository: StoreSettingRepository(context.read<HttpClient>()),
                        googlePlaceRepository: GooglePlaceRepository(googleMapApiKey: googleMapApiKey)..init(),
                        token: context.read<AuthenticationBloc>().state.token,
                        value: context.read<GlobalBloc>().state.stores['store_setting'],
                        storeNameInit: "${state.user.firstName} ${state.user.lastName}",
                        storeEmailInit: state.user.userEmail,
                        onChanged: (store) =>
                            context.read<GlobalBloc>().add(GlobalStoreChanged('store_setting', store)));
                  },
                  child: const StoreSetupScreen(),
                );
              }
              return HomeTabs(
                firebaseMessageRepository: firebaseMessageRepository,
              );
            }
            return const LoginScreen();
          },
        );
      },
    );
  }
}

class HomeTabs extends StatefulWidget {
  final FirebaseMessageRepository firebaseMessageRepository;
  const HomeTabs({Key? key, required this.firebaseMessageRepository}) : super(key: key);

  @override
  State<HomeTabs> createState() => _HomeTabsState();
}

const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
const List<Widget> _widgetOptions = <Widget>[
  HomeTab(),
  ProductsScreen(),
  OrdersPage(),
  ChatListScreen(),
  ProfilePage(),
];

class _HomeTabsState extends State<HomeTabs> with MessagingMixin {
  Future<bool> back() async {
    if (!context.read<TabsCubit>().canUndo) {
      return true;
    }
    context.read<TabsCubit>().undo();
    return false;
  }

  @override
  void initState() {
    subscribe(() async {
      try {
        String? token = await getToken();
        Map<String, dynamic> data = {'token': token};
        await widget.firebaseMessageRepository.updateUserToken(
            requestData: RequestData(
          data: data,
          query: {'app-builder-decode': true},
          token: userToken,
        ));
      } catch (_) {
        rethrow;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabsCubit, int>(builder: (context, index) {
      ThemeData theme = Theme.of(context);

      return WillPopScope(
        onWillPop: back,
        child: Scaffold(
          body: Center(
            child: _widgetOptions.elementAt(index),
          ),
          bottomNavigationBar: BottomBarDefault(
            items: [
              TabItem(
                icon: CommunityMaterialIcons.storefront,
                title: AppLocalizations.of(context)!.translate('tabbar:text_home'),
              ),
              TabItem(
                icon: CommunityMaterialIcons.cube,
                title: AppLocalizations.of(context)!.translate('tabbar:text_product'),
              ),
              TabItem(
                icon: CommunityMaterialIcons.receipt,
                title: AppLocalizations.of(context)!.translate('tabbar:text_order'),
              ),
              TabItem(
                icon: CommunityMaterialIcons.chat_processing,
                title: AppLocalizations.of(context)!.translate('tabbar:text_chat'),
              ),
              TabItem(
                icon: CommunityMaterialIcons.account_circle,
                title: AppLocalizations.of(context)!.translate('tabbar:text_account'),
              ),
            ],
            backgroundColor: theme.cardColor,
            color: theme.textTheme.caption!.color!,
            colorSelected: theme.primaryColor,
            animated: false,
            indexSelected: index,
            iconSize: 24,
            top: 10,
            bottom: 10,
            titleStyle: theme.textTheme.overline?.copyWith(
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
            boxShadow: initShadow,
            onTap: context.read<TabsCubit>().onItemTapped,
          ),
        ),
      );
    });
  }
}
