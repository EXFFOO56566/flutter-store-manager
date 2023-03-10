import 'package:flutter/material.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:flutter_store_manager/themes.dart';

import 'notification_icon_item.dart';
import 'notification_status_item.dart';

class NotificationItem extends StatelessWidget with NotificationMixin {
  final NotificationData? notification;
  final EdgeInsetsGeometry? padding;
  final double? indentDivider;
  final double? endIndentDivider;

  const NotificationItem({
    Key? key,
    required this.notification,
    this.padding,
    this.indentDivider,
    this.endIndentDivider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    bool loading = notification?.id == null;

    return NotificationItemUi(
      icon: NotificationIconItem(
        type: notification?.messageType ?? '',
        loading: loading,
      ),
      title: buildTitle(text: notification?.message?.unescape, theme: theme, isLoading: loading),
      status: NotificationStatusItem(
        type: notification?.messageType ?? '',
        loading: loading,
      ),
      type: buildType(isLoading: loading),
      dateTime: buildDateTime(
        date: formatDate(date: notification?.created ?? DateTime.now().toString(), dateFormat: 'dd/MM/yyyy'),
        time: formatDate(date: notification?.created ?? DateTime.now().toString(), dateFormat: 'hh:mm a'),
        theme: theme,
        isLoading: loading,
      ),
      padding: padding,
      indentDivider: indentDivider ?? 70,
      endIndentDivider: endIndentDivider,
      dividerColor: theme.dividerColor,
      onTap: () {},
    );
  }
}
