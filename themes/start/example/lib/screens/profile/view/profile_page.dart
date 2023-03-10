import 'package:example/notification/notification_list.dart';
import 'package:example/screens/enquiry_board/view/enquiry_board_page.dart';
import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:ui/ui.dart';
import 'package:example/screens/screens.dart';

import '../widgets/widgets.dart';

class ProfilePage extends StatelessWidget with AppbarMixin {
  static const routeName = '/profile';
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
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
                  title: '1',
                  background: Color(0xFFFA1616),
                  size: 28,
                  padHorizontal: 5,
                ),
                onTap: () => Navigator.pushNamed(context, NotificationListScreen.routeName),
              ),
              TileIconLine(
                icon: CommunityMaterialIcons.help_circle_outline,
                title: 'Enquiry Board',
                isChevron: true,
                onTap: () => Navigator.pushNamed(context, EnquiryBoardPage.routeName),
              ),
              TileIconLine(
                icon: CommunityMaterialIcons.star_circle,
                title: 'All Reviews',
                isChevron: true,
                onTap: () => Navigator.pushNamed(context, ReviewListPage.routeName),
              ),
              TileIconLine(
                icon: CommunityMaterialIcons.chart_pie,
                title: 'Reports',
                isChevron: true,
                onTap: () => Navigator.pushNamed(context, ReportPage.routeName),
              ),
              TileIconLine(
                icon: CommunityMaterialIcons.image_multiple,
                title: 'Media',
                isChevron: true,
                onTap: () {},
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
                onTap: () {},
              ),
              const SwitchDarkMode(),
              const SelectLanguage(),
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
