import 'package:flutter_store_manager/common/bloc/state_base.dart';
import 'package:notification_repository/notification_repository.dart';

class NotificationState extends BaseState {
  final List<NotificationData> notificationList;
  final BaseState actionState;
  final BaseState deleteState;
  final int nextPage;
  final CountNotificationData? countNotification;
  final bool updateData;
  const NotificationState({
    this.notificationList = const [],
    this.actionState = const InitState(),
    this.deleteState = const InitState(),
    this.nextPage = 0,
    this.countNotification,
    this.updateData = false,
  });
  NotificationState copyWith({
    List<NotificationData>? notificationList,
    BaseState? actionState,
    BaseState? deleteState,
    int? nextPage,
    CountNotificationData? countNotification,
    bool? updateData,
  }) {
    return NotificationState(
      notificationList: notificationList ?? this.notificationList,
      nextPage: nextPage ?? this.nextPage,
      actionState: actionState ?? this.actionState,
      deleteState: deleteState ?? this.deleteState,
      countNotification: countNotification ?? this.countNotification,
      updateData: updateData ?? this.updateData,
    );
  }

  @override
  List<Object?> get props => [
        notificationList,
        actionState,
        deleteState,
        nextPage,
        countNotification,
      ];
}
