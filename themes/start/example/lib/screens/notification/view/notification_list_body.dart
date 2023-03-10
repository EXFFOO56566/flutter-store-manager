import 'package:community_material_icon/community_material_icon.dart';
import 'package:example/blocs/blocs.dart';
import 'package:example/screens/notification/cubit/notification_list_cubit.dart';
import 'package:example/screens/notification/models/notification.dart';
import 'package:example/widgets/notification_item.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ui/ui.dart';

import '../../../widgets/widgets.dart';

class NotificationListBody extends StatefulWidget {
  const NotificationListBody({Key? key}) : super(key: key);

  @override
  State<NotificationListBody> createState() => _NotificationListBodyState();
}

class _NotificationListBodyState extends State<NotificationListBody> {
  late NotificationListCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<NotificationListCubit>();
    _cubit.getnotifications();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future _loadMore() async {
    await _cubit.loadMore();
  }

  Future _refresh() async {
    await _cubit.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationListCubit, NotificationListState>(
      builder: (context, state) {
        final canLoadMore = _cubit.canLoadMore;
        return state.actionState is! LoadingState && state.notifications.isEmpty
            ? const NotificationEmptyView(
                icon: CommunityMaterialIcons.bell,
                title: 'Empty Notifications',
              )
            : BaseSmartFresher(
                onRefresh: _refresh,
                onLoadMore: canLoadMore ? _loadMore : null,
                child: _body(state, context),
              );
      },
    );
  }

  Widget _body(NotificationListState state, BuildContext context) {
    List<NotificationList> emptyNotification = List.generate(_cubit.perPage, (index) => NotificationList()).toList();
    List<NotificationList> data = state.actionState is LoadingState ? emptyNotification : state.notifications;
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double width = mediaQuery.size.width;
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        return Slidable(
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
          child: NotificationItem(
            notifications: item,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            indentDivider: 105,
            endIndentDivider: 25,
          ),
        );
      },
    );
  }
}
