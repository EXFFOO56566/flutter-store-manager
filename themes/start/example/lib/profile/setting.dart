import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:ui/ui.dart';

import '../screens.dart';

class SettingScreen extends StatelessWidget with AppbarMixin {
  static const routeName = '/setting';

  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseStyleAppBar(title: 'Settings Store'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(25, 8, 25, 32),
        child: SettingContainer(
          profile: ListContent(
            title: 'Profile Manager',
            children: [
              TileIconLine(
                icon: CommunityMaterialIcons.badge_account_horizontal,
                title: 'Personal',
                isChevron: true,
                onTap: () => Navigator.pushNamed(context, SettingPersonScreen.routeName),
              ),
              TileIconLine(
                icon: CommunityMaterialIcons.map_marker,
                title: 'Address',
                isChevron: true,
                onTap: () => Navigator.pushNamed(context, SettingPersonAddressScreen.routeName),
              ),
              TileIconLine(
                icon: CommunityMaterialIcons.share_circle,
                title: 'Sharing Social',
                isChevron: true,
                onTap: () => Navigator.pushNamed(context, SettingPersonSocialScreen.routeName),
              ),
            ],
          ),
          store: ListContent(
            title: 'Store Manager',
            children: [
              TileIconLine(
                icon: CommunityMaterialIcons.store,
                title: 'Store',
                isChevron: true,
                onTap: () => Navigator.pushNamed(context, SettingStoreScreen.routeName),
              ),
              TileIconLine(
                icon: CommunityMaterialIcons.bank,
                title: 'Payment',
                isChevron: true,
                onTap: () => Navigator.pushNamed(context, SettingStorePaymentScreen.routeName),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
