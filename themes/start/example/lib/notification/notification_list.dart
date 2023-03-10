import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ui/ui.dart';

import '../widgets/notification_item.dart';

class NotificationListScreen extends StatelessWidget with AppbarMixin {
  static const routeName = '/notification-list';

  const NotificationListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double width = mediaQuery.size.width;
    return Scaffold(
      appBar: baseStyleAppBar(title: 'Notifications'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(0, 4, 0, 25),
        child: Column(
          children: List.generate(
            10,
            (index) => Slidable(
              key: ValueKey(index),
              endActionPane: ActionPane(
                extentRatio: 116 / width,
                motion: const ScrollMotion(),
                children: [
                  Expanded(child: ButtonSlidable(icon: CommunityMaterialIcons.check, onPressed: () {})),
                  Expanded(
                    child: ButtonSlidable(
                      icon: CommunityMaterialIcons.trash_can_outline,
                      colorIcon: const Color(0xFFFF5200),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
              child: const NotificationItem(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                indentDivider: 105,
                endIndentDivider: 25,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
