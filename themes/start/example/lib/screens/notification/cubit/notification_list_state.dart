part of 'notification_list_cubit.dart';

class NotificationListState extends Equatable {
  final List<NotificationList> notifications;
  final BaseState actionState;
  final int page;
  const NotificationListState({
    this.notifications = const [],
    this.actionState = const InitState(),
    this.page = 0,
  });

  @override
  List<Object> get props => [
        notifications,
        actionState,
        page,
      ];
  NotificationListState copyWith({
    List<NotificationList>? notifications,
    BaseState? actionState,
    int? page,
  }) {
    return NotificationListState(
      notifications: notifications ?? this.notifications,
      actionState: actionState ?? this.actionState,
      page: page ?? this.page,
    );
  }
}

class NotificationListInitial extends NotificationListState {}
