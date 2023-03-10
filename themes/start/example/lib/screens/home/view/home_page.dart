import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:example/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:example/blocs/blocs.dart';
import 'package:example/screens/screens.dart';

const List<Widget> _widgetOptions = <Widget>[
  HomeTab(),
  ProductListPage(),
  OrderListPage(),
  ChatListPage(),
  ProfilePage(),
];

class HomePage extends StatelessWidget {
  static const routeName = '/';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingCubit, SettingState>(
      builder: (context, state) {
        if (state.showOnBoarding) {
          return const OnBoardingPage();
        }
        return BlocBuilder<AuthCubit, AuthState>(
          builder: (_, stateAuth) {
            if (stateAuth.isLogin) {
              return _HomeScreen();
            }
            return const LoginPage();
          },
        );
      },
    );
  }
}

class _HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<_HomeScreen> {
  Future<bool> back() async {
    if (!context.read<TabBarCubit>().canUndo) {
      return true;
    }
    context.read<TabBarCubit>().undo();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBarCubit, int>(builder: (context, index) {
      ThemeData theme = Theme.of(context);

      return WillPopScope(
        onWillPop: back,
        child: Scaffold(
          body: Center(
            child: _widgetOptions.elementAt(index),
          ),
          bottomNavigationBar: BottomBarDefault(
            items: const [
              TabItem(
                icon: CommunityMaterialIcons.storefront,
                title: 'Home',
              ),
              TabItem(
                icon: CommunityMaterialIcons.cube,
                title: 'Products',
              ),
              TabItem(
                icon: CommunityMaterialIcons.receipt,
                title: 'Order',
              ),
              TabItem(
                icon: CommunityMaterialIcons.chat_processing,
                title: 'Chat',
              ),
              TabItem(
                icon: CommunityMaterialIcons.account_circle,
                title: 'Account',
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
            titleStyle: theme.textTheme.overline?.copyWith(fontSize: 11, fontWeight: FontWeight.w700, height: 13 / 11),
            boxShadow: initShadow,
            onTap: context.read<TabBarCubit>().onItemTapped,
          ),
        ),
      );
    });
  }
}
