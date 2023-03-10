import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_store_manager/pages/notification/bloc/notification_cubit.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:flutter_store_manager/pages/notification/view/notification_appbar_leading.dart';
import 'package:flutter_store_manager/stores/global/global_store.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:flutter_store_manager/themes.dart';

import 'notification_list.dart';

class NotificationPage extends StatelessWidget with AppbarMixin {
  static const routeName = '/NotificationPage';
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotificationCubit>(
      create: (context) {
        return NotificationCubit(
          notificationRepository: NotificationRepository(context.read<HttpClient>()),
          token: context.read<AuthenticationBloc>().state.token,
          value: context.read<GlobalBloc>().state.stores['notifications'],
          onChanged: (store) => context.read<GlobalBloc>().add(GlobalStoreChanged('notifications', store)),
        );
      },
      child: Scaffold(
        appBar: baseStyleAppBar(
          leadingWidget: const NotificationAppbarLeading(),
          title: AppLocalizations.of(context)!.translate('notification:text_notifications'),
        ),
        body: const NotificationList(),
      ),
    );
  }
}
