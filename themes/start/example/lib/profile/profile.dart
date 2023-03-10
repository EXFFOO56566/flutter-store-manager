import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:collection/collection.dart';
import 'package:ui/ui.dart';

import '../screens.dart';
import 'widgets/profile_user.dart';

List<Option> _languages = const [
  Option(key: 'us', name: 'Unit State'),
  Option(key: 'en', name: 'English'),
  Option(key: 'vn', name: 'Viet Nam'),
];

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with AppbarMixin {
  bool _themeDarkMode = false;
  String _lang = 'en';

  void clickLanguage(BuildContext context) async {
    String? value = await showModalBottomSheet<String?>(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        MediaQueryData mediaQuery = MediaQuery.of(context);
        return Container(
          constraints: BoxConstraints(maxHeight: mediaQuery.size.height * 0.6),
          child: ModalOptionSingleFooterView(
            options: _languages,
            value: _lang,
            onPressButton: (String? text) => Navigator.pop(context, text),
          ),
        );
      },
    );
    if (value != null && value != _lang) {
      setState(() {
        _lang = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Option? languageSelect = _languages.firstWhereOrNull((e) => e.key == _lang);
    return Scaffold(
      appBar: baseStyleAppBar(
        automaticallyImplyLeading: false,
        title: 'Profile',
      ),
      body: ProfileContainer(
          padding: const EdgeInsets.fromLTRB(25, 0, 25, 32),
          user: const ProfileUser(),
          information: ListContent(
            children: [
              TileIconLine(
                icon: CommunityMaterialIcons.email_open,
                title: 'Inbox Notifications',
                trailing: const Badge(
                  title: '13',
                  background: Color(0xFFFA1616),
                  size: 28,
                  padHorizontal: 5,
                ),
                onTap: () => Navigator.pushNamed(context, NotificationListScreen.routeName),
              ),
              TileIconLine(
                icon: CommunityMaterialIcons.star_circle,
                title: 'All Reviews',
                isChevron: true,
                onTap: () => Navigator.pushNamed(context, ReviewListScreen.routeName),
              ),
              TileIconLine(
                icon: CommunityMaterialIcons.chart_pie,
                title: 'Reports',
                isChevron: true,
                onTap: () => Navigator.pushNamed(context, ReportScreen.routeName),
              ),
              TileIconLine(
                icon: CommunityMaterialIcons.image_multiple,
                title: 'Media',
                isChevron: true,
                onTap: () => Navigator.pushNamed(context, MediaListScreen.routeName),
              ),
            ],
          ),
          setting: ListContent(
            title: 'Settings',
            children: [
              TileIconLine(
                icon: CommunityMaterialIcons.cog,
                title: 'Settings Store',
                isChevron: true,
                onTap: () => Navigator.pushNamed(context, SettingScreen.routeName),
              ),
              TileIconLine(
                icon: Icons.opacity,
                title: 'Dark Mode',
                trailing: CupertinoSwitch(
                  value: _themeDarkMode,
                  onChanged: (_) => setState(() {
                    _themeDarkMode = !_themeDarkMode;
                  }),
                ),
              ),
              TileIconLine(
                icon: CommunityMaterialIcons.translate,
                title: 'Languages',
                isChevron: true,
                trailing: Text(
                  languageSelect?.name ?? '',
                  style: theme.textTheme.overline?.copyWith(color: theme.textTheme.caption?.color),
                ),
                onTap: () => clickLanguage(context),
              ),
              TileIconLine(
                icon: CommunityMaterialIcons.star,
                title: 'Rate this App',
                onTap: () {},
              ),
            ],
          ),
          footer: Padding(
            padding: const EdgeInsetsDirectional.only(start: 44),
            child: Text('Version 1.0.0', style: theme.textTheme.overline),
          )),
    );
  }
}
