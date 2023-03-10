import 'package:example/screens/notification/cubit/notification_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/ui.dart';

import 'notification_list_body.dart';

class NotificationPage extends StatelessWidget with AppbarMixin {
  static const routeName = '/notification-list';
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return NotificationListCubit();
      },
      child: Scaffold(
        appBar: baseStyleAppBar(title: 'Notifications'),
        body: const NotificationListBody(),
      ),
    );
  }
}
