import 'package:example/screens/notification/models/notification.dart';
import 'package:example/utils/date_format.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class NotificationItem extends StatelessWidget with NotificationMixin {
  final EdgeInsetsGeometry? padding;
  final double? indentDivider;
  final double? endIndentDivider;
  final NotificationList? notifications;

  const NotificationItem({
    Key? key,
    this.padding,
    this.indentDivider,
    this.endIndentDivider,
    this.notifications,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    bool loading = notifications?.id is! String;
    return NotificationItemUi(
      icon: buildIcon(icon: Icons.chat, theme: theme, isLoading: loading),
      title: buildTitle(text: notifications?.message ?? '', theme: theme, isLoading: loading),
      status: buildStatus(
          text: notifications?.messageType, color: const Color(0xFF2BBD69), theme: theme, isLoading: loading),
      type: buildType(isLoading: loading),
      dateTime: buildDateTime(
          date: formatDate(date: notifications?.created ?? DateTime.now().toString(), dateFormat: 'dd/MM/yyyy'),
          time: formatDate(date: notifications?.created ?? DateTime.now().toString(), dateFormat: 'hh:mm a'),
          theme: theme,
          isLoading: loading),
      padding: padding,
      indentDivider: indentDivider ?? 70,
      endIndentDivider: endIndentDivider,
      dividerColor: theme.dividerColor,
      onTap: () {},
    );
  }
}
