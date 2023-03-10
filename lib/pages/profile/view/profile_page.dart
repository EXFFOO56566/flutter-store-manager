import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/authentication/authentication.dart';
import 'package:flutter_store_manager/constants/rate_app.dart';
import 'package:flutter_store_manager/pages/pages.dart';
import 'package:flutter_store_manager/pages/store_setting/view/setting_store_page.dart';
import 'package:flutter_store_manager/stores/global/global_store.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:notification_repository/notification_repository.dart';

import 'profile_dark_mode.dart';
import 'profile_language.dart';
import 'profile_user.dart';

class ProfilePage extends StatelessWidget with AppbarMixin {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: baseStyleAppBar(
        automaticallyImplyLeading: false,
        title: AppLocalizations.of(context)!.translate('account:text_profile'),
      ),
      body: ProfileContainer(
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 32),
        user: const ProfileUser(),
        information: ListContent(
          children: [
            BlocProvider(
              create: (context) => NotificationCubit(
                  notificationRepository: NotificationRepository(context.read<HttpClient>()),
                  token: context.read<AuthenticationBloc>().state.token,
                  value: context.read<GlobalBloc>().state.stores['notifications'],
                  onChanged: (store) => context.read<GlobalBloc>().add(GlobalStoreChanged('notifications', store))),
              child: const NotificationTask(),
            ),
            TileIconLine(
              icon: CommunityMaterialIcons.star_circle,
              title: AppLocalizations.of(context)!.translate('account:text_review'),
              isChevron: true,
              onTap: () => Navigator.pushNamed(context, ReviewListPage.routeName),
            ),
            TileIconLine(
              icon: CommunityMaterialIcons.chart_pie,
              title: AppLocalizations.of(context)!.translate('account:text_report'),
              isChevron: true,
              onTap: () => Navigator.pushNamed(context, ReportPage.routeName),
            ),
            TileIconLine(
              icon: CommunityMaterialIcons.image_multiple,
              title: AppLocalizations.of(context)!.translate('account:text_media'),
              isChevron: true,
              onTap: () => Navigator.pushNamed(context, MediaListScreen.routeName),
            ),
          ],
        ),
        setting: ListContent(
          title: AppLocalizations.of(context)!.translate('account:text_setting'),
          children: [
            TileIconLine(
              icon: CommunityMaterialIcons.cog,
              title: AppLocalizations.of(context)!.translate('account:text_setting_store'),
              isChevron: true,
              onTap: () => Navigator.pushNamed(context, SettingStorePage.routeName),
            ),
            const ProfileDarkMode(),
            const ProfileLanguage(),
            TileIconLine(
              icon: CommunityMaterialIcons.account_cancel_outline,
              title: AppLocalizations.of(context)!.translate('delete_account:text_txt'),
              onTap: () => Navigator.pushNamed(context, DeleteAccountPage.routeName),
            ),
            TileIconLine(
              icon: CommunityMaterialIcons.star,
              title: AppLocalizations.of(context)!.translate('account:text_rate'),
              onTap: () async {
                final InAppReview inAppReview = InAppReview.instance;
                if (await inAppReview.isAvailable()) {
                  inAppReview.openStoreListing(
                    appStoreId: appStoreId,
                    microsoftStoreId: microsoftStoreId,
                  );
                }
              },
            ),
          ],
        ),
        footer: Padding(
          padding: const EdgeInsetsDirectional.only(start: 44),
          child: Text(AppLocalizations.of(context)!.translate(''), style: theme.textTheme.overline),
        ),
      ),
    );
  }
}

class NotificationTask extends StatefulWidget {
  const NotificationTask({Key? key}) : super(key: key);
  @override
  NotificationTaskState createState() => NotificationTaskState();
}

class NotificationTaskState extends State<NotificationTask> {
  late NotificationCubit cubit;
  @override
  void initState() {
    cubit = context.read<NotificationCubit>();
    cubit.getCountNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        return Column(
          children: [
            TileIconLine(
              icon: CommunityMaterialIcons.email_open,
              title: AppLocalizations.of(context)!.translate('account:text_inbox_notification'),
              trailing: Badge(
                title: state.countNotification?.message ?? '0',
                background: const Color(0xFFFA1616),
                size: 28,
                padHorizontal: 5,
              ),
              onTap: () => Navigator.of(context).pushNamed(NotificationPage.routeName).then((value) {
                if (value == true) {
                  cubit.getCountNotification();
                }
              }),
            ),
            TileIconLine(
              icon: CommunityMaterialIcons.help_circle_outline,
              title: AppLocalizations.of(context)!.translate('enquiry:text_enquiry'),
              trailing: Badge(
                title: state.countNotification?.enquiry ?? '0',
                background: const Color(0xFFFA1616),
                size: 28,
                padHorizontal: 5,
              ),
              onTap: () => Navigator.of(context).pushNamed(EnquiryBoardPage.routeName).then((value) {
                cubit.getCountNotification();
              }),
            ),
          ],
        );
      },
    );
  }
}
