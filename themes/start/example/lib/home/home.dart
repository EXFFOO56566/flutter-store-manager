import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:ui/ui.dart';

import '../contants.dart';
import '../screens.dart';
import 'widgets/avatar_user.dart';

/// Static screens
Map<String, Widget> _widgetOptions = {
  'screens_home': const HomeTab(),
  "screens_product": const ProductListScreen(),
  "screens_order": const OrderListScreen(),
  "screens_chat": const ChatListScreen(),
  "screens_profile": const ProfileScreen(),
};

/// Items bottom bar
List<TabItem> _items = [
  const TabItem(icon: CommunityMaterialIcons.storefront, title: 'Home', key: 'screens_home'),
  const TabItem(icon: CommunityMaterialIcons.cube, title: 'Products', key: 'screens_product'),
  const TabItem(icon: CommunityMaterialIcons.receipt, title: 'Order', key: 'screens_order'),
  const TabItem(icon: CommunityMaterialIcons.chat_processing, title: 'Chat', key: 'screens_chat'),
  const TabItem(icon: CommunityMaterialIcons.account_circle, title: 'Account', key: 'screens_profile'),
];

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    TabItem tabSelected = _items[_currentIndex];

    return Scaffold(
      bottomNavigationBar: BottomBarDefault(
        items: _items,
        backgroundColor: theme.cardColor,
        color: theme.textTheme.caption!.color!,
        colorSelected: theme.primaryColor,
        animated: false,
        indexSelected: _currentIndex,
        iconSize: 24,
        top: 10,
        bottom: 10,
        titleStyle: theme.textTheme.overline?.copyWith(
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
        boxShadow: initShadow,
        onTap: (int visit) {
          if (visit != _currentIndex) {
            setState(() {
              _currentIndex = visit;
            });
          }
        },
      ),
      body: _widgetOptions[tabSelected.key],
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            HomeUser(
              title: 'Hi, Demo Vendor',
              time: 'Dec, 12, 2019',
              avatar: AvatarUser(),
            )
          ],
        ),
      ),
    );
  }
}
