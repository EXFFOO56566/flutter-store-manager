import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:example/blocs/blocs.dart';
import 'package:example/mocks/notification_mock.dart';

import '../models/notification.dart';

part 'notification_list_state.dart';

class NotificationListCubit extends Cubit<NotificationListState> {
  final perPage = 10;
  NotificationListCubit() : super(NotificationListInitial());

  Future<void> getnotifications() async {
    try {
      emit(state.copyWith(
        actionState: const LoadingState(),
      ));
      await _getnotifications(page: 1);
    } catch (_) {}
  }

  Future<void> refresh() async {
    await _getnotifications(page: 1);
  }

  Future<void> loadMore() async {
    await _getnotifications(page: state.page + 1);
  }

  Future<void> _getnotifications({int page = 1}) async {
    try {
      final data = await getNotificationListApi(page: page, perPage: perPage);
      List<NotificationList> notificationResponse = <NotificationList>[];
      notificationResponse =
          data.map((notification) => NotificationList.fromJson(notification)).toList().cast<NotificationList>();
      var newNotification = state.notifications;
      if (page == 1) {
        newNotification = notificationResponse;
      } else {
        newNotification.addAll(notificationResponse);
      }
      emit(
        state.copyWith(
          actionState: LoadedState(data: newNotification.length),
          notifications: newNotification,
          page: page,
        ),
      );
    } catch (e) {
      emit(state.copyWith(actionState: ErrorState(data: e.toString())));
      rethrow;
    }
  }

  bool get canLoadMore => state.notifications.length >= (state.page * perPage);
}
