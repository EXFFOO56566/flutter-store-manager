// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter_store_manager/pages/pages.dart';
import 'package:flutter_store_manager/types/types.dart';

// View
import 'setup_policy/setup_policy_page.dart';
import 'setup_seo/setup_seo_page.dart';
import 'setup_social/setup_social_page.dart';
import 'setup_support/setup_support.dart';
import 'update_store_info/view/update_store_info_page.dart';
import 'update_store_payment/update_store_payment.dart';
import 'package:flutter_store_manager/pages/update_personal/view/update_personal_screen.dart';
import 'package:flutter_store_manager/themes.dart';

class SettingStorePage extends StatelessWidget with AppbarMixin {
  static const routeName = '/SettingStorePage';

  const SettingStorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    bool disable = true;

    return Scaffold(
      appBar: baseStyleAppBar(title: translate('account:text_setting_store')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(25, 8, 25, 32),
        child: SettingContainer(
          profile: ListContent(
            title: translate('account:text_profile_manager'),
            children: [
              TileIconLine(
                icon: CommunityMaterialIcons.badge_account_horizontal,
                title: translate('account:text_personal'),
                isChevron: true,
                onTap: () => Navigator.of(context).pushNamed(UpdatePersonalScreen.routeName),
              ),
              if (disable == true)
                TileIconLine(
                  icon: CommunityMaterialIcons.map_marker,
                  title: translate('account:text_address'),
                  isChevron: true,
                  onTap: () => Navigator.pushNamed(context, UpdatePersonalAddressScreen.routeName),
                ),
              TileIconLine(
                icon: CommunityMaterialIcons.onepassword,
                title: translate('account:text_change_password'),
                isChevron: true,
                onTap: () => Navigator.pushNamed(context, UpdatePasswordScreen.routeName),
              ),
            ],
          ),
          store: ListContent(
            title: translate('account:text_store_manager'),
            children: [
              TileIconLine(
                icon: CommunityMaterialIcons.store,
                title: translate('account:text_store'),
                isChevron: true,
                onTap: () => Navigator.pushNamed(context, UpdateStoreInfoScreen.routeName),
              ),
              TileIconLine(
                icon: CommunityMaterialIcons.bank,
                title: translate('account:text_payment'),
                isChevron: true,
                onTap: () => Navigator.pushNamed(context, UpdateStorePaymentScreen.routeName),
              ),
              TileIconLine(
                icon: Icons.policy_outlined,
                title: translate('auth:text_policy'),
                onTap: () async {
                  Navigator.pushNamed(context, SetupPolicyPage.routeName);
                },
                isChevron: true,
              ),
              TileIconLine(
                icon: Icons.support_outlined,
                title: translate('auth:text_support'),
                onTap: () async {
                  Navigator.pushNamed(context, SetupSupportPage.routeName);
                },
                isChevron: true,
              ),
              TileIconLine(
                icon: Icons.search_off_outlined,
                title: translate('auth:text_seo'),
                onTap: () async {
                  Navigator.pushNamed(context, SetupSeoPage.routeName);
                },
                isChevron: true,
              ),
              TileIconLine(
                icon: CommunityMaterialIcons.share_circle,
                title: translate('auth:text_social'),
                onTap: () async {
                  Navigator.pushNamed(context, SetupSocialPage.routeName);
                },
                isChevron: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
