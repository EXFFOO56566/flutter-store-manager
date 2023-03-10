import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_store_manager/common/widgets/base_smart_fresher.dart';

import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:flutter_store_manager/themes.dart';

import '../../../common/bloc/state_base.dart';
import '../bloc/notification_cubit.dart';
import '../bloc/notification_state.dart';
import '../widget/notification_item.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({Key? key}) : super(key: key);

  @override
  NotificationListState createState() => NotificationListState();
}

class NotificationListState extends State<NotificationList> with LoadingMixin {
  late NotificationCubit cubit;
  @override
  void initState() {
    cubit = context.read<NotificationCubit>();
    cubit.getNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        final canLoadMore = cubit.canLoadMore;
        if (state.actionState is! LoadingState && state.notificationList.isEmpty) {
          return NotificationEmptyView(
            icon: CommunityMaterialIcons.bell,
            title: AppLocalizations.of(context)!.translate('notification:text_empty'),
          );
        }
        return BaseSmartFresher(
          onRefresh: _refresh,
          onLoadMore: canLoadMore ? _loadMore : null,
          child: buildList(context, state),
        );
      },
    );
  }

  Widget buildList(BuildContext context, NotificationState state) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double width = mediaQuery.size.width;

    List<NotificationData> emptyProducts = List.generate(10, (index) => NotificationData()).toList();
    List<NotificationData> data = state.actionState is LoadingState ? emptyProducts : state.notificationList;
    TranslateType translate = AppLocalizations.of(context)!.translate;
    return ListView.builder(
      padding: const EdgeInsets.only(top: 4),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final value = data.elementAt(index);
        final item = NotificationItem(
          notification: value,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          indentDivider: 105,
          endIndentDivider: 25,
        );
        if (value.id != null) {
          return Slidable(
            key: ValueKey(value.id),
            endActionPane: ActionPane(
              extentRatio: 116 / width,
              motion: const ScrollMotion(),
              children: [
                Expanded(
                    child: ButtonSlidable(
                  icon: CommunityMaterialIcons.check,
                  onPressed: () {
                    cubit.updateReadNotification(messageId: value.id);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(translate('common:text_mark_read')),
                    ));
                  },
                )),
                Expanded(
                  child: ButtonSlidable(
                    icon: CommunityMaterialIcons.trash_can_outline,
                    colorIcon: const Color(0xFFFF5200),
                    onPressed: () {
                      cubit.deleteNotificationUi(messageId: value.id);
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(
                            content: Text(translate('common:text_deleted')),
                            action: SnackBarAction(
                              label: translate('common:text_undo'),
                              onPressed: () {
                                cubit.undo();
                              },
                            ),
                          ))
                          .closed
                          .then(
                        (valueMessenger) {
                          if (valueMessenger == SnackBarClosedReason.timeout ||
                              valueMessenger == SnackBarClosedReason.hide) {
                            cubit.deleteNotification(messageId: value.id);
                          }
                        },
                      );
                    },
                  ),
                )
              ],
            ),
            child: item,
          );
        }
        return item;
      },
    );
  }

  Future _loadMore() async {
    await cubit.loadMore();
  }

  Future _refresh() async {
    await cubit.refresh();
  }
}
