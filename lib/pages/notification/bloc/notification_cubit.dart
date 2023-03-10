import 'package:equatable/equatable.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:replay_bloc/replay_bloc.dart';

import 'notification_state.dart';

class NotificationCubit extends ReplayCubit<NotificationState> {
  final NotificationRepository notificationRepository;
  final void Function(BaseState store) onChanged;
  final RequestCancel _cancelToken = RequestCancel();
  final String token;
  int perPage = 10;
  NotificationCubit({
    required this.notificationRepository,
    required this.token,
    Equatable? value,
    required this.onChanged,
  }) : super(value != null ? value as NotificationState : const NotificationState());

  Future<void> getNotification() async {
    emit(state.copyWith(
      actionState: const LoadingState(),
    ));
    await _getNotification(nextPage: 1);
  }

  Future<void> refresh() async {
    await _getNotification(nextPage: 1);
  }

  Future<void> loadMore() async {
    await _getNotification(nextPage: state.nextPage + 1);
  }

  Future<void> _getNotification({int nextPage = 1}) async {
    try {
      List<NotificationData> notificationList = await notificationRepository.getNotifications(
        requestData: RequestData(
          token: token,
          query: {
            "page": nextPage,
            "per_page": perPage,
            'app-builder-decode': true,
          },
          cancelToken: _cancelToken,
        ),
      );
      var newNotification = state.notificationList;
      if (nextPage == 1) {
        newNotification = notificationList;
      } else {
        newNotification.addAll(notificationList);
      }
      emit(
        state.copyWith(
          notificationList: newNotification,
          actionState: LoadedState(data: newNotification.length),
          nextPage: nextPage,
        ),
      );
    } catch (e) {
      emit(state.copyWith(actionState: ErrorState(data: e.toString())));
      avoidPrint(e);
    }
  }

  Future<void> getCountNotification() async {
    try {
      CountNotificationData res = await notificationRepository.getCountNotification(
        requestData: RequestData(
          token: token,
          query: {
            'app-builder-decode': true,
            'range': 'year',
          },
          cancelToken: _cancelToken,
        ),
      );
      emit(state.copyWith(countNotification: res));
    } catch (e) {
      avoidPrint(e);
    }
  }

  Future<void> updateReadNotification({String? messageId}) async {
    try {
      await notificationRepository.updateReadNotification(
        requestData: RequestData(
          token: token,
          data: {'message_id': messageId},
          query: {
            'app-builder-decode': true,
          },
          cancelToken: _cancelToken,
        ),
      );
      refresh();
      emit(state.copyWith(updateData: true));
    } catch (e) {
      avoidPrint(e);
    }
  }

  Future<void> deleteNotification({String? messageId}) async {
    await _deleteNotification(messageId: messageId);
  }

  Future<void> deleteNotificationUi({String? messageId}) async {
    if (messageId != null) {
      final data = [...state.notificationList];
      data.removeWhere((e) => e.id == messageId);
      emit(state.copyWith(
        actionState: LoadedState(data: data.length),
        notificationList: data,
      ));
    } else {}
  }

  Future<void> _deleteNotification({String? messageId}) async {
    if (messageId != null) {
      try {
        await notificationRepository.deleteNotification(
          requestData: RequestData(
            token: token,
            query: {
              'app-builder-decode': true,
              'message_id': messageId,
            },
            cancelToken: _cancelToken,
          ),
        );
        emit(state.copyWith(
          deleteState: const LoadedState(),
          updateData: true,
        ));
      } on RequestError catch (_) {
        undo();
        emit(state.copyWith(deleteState: const ErrorState()));
        rethrow;
      }
    } else {}
  }

  bool get canLoadMore => state.notificationList.length >= (state.nextPage * perPage);

  @override
  void onChange(Change<NotificationState> change) {
    super.onChange(change);
    onChanged(change.nextState);
  }

  @override
  Future<void> close() {
    _cancelToken.cancel();
    return super.close();
  }
}
