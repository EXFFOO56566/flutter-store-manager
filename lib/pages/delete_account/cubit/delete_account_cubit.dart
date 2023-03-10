// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:authentication_repository/authentication_repository.dart';

// Packages & Dependencies or Helper function
import 'package:equatable/equatable.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:replay_bloc/replay_bloc.dart';

// Repository packages
part 'delete_account_state.dart';

class DeleteAccountCubit extends ReplayCubit<DeleteAccountState> {
  final AuthenticationRepository authenticationRepository;
  final String token;

  final RequestCancel _cancelToken = RequestCancel();

  DeleteAccountCubit({
    required this.authenticationRepository,
    required this.token,
  }) : super(const DeleteAccountState());

  void changeReason(Option data) {
    emit(state.copyWith(reason: data));
  }

  void changeIsAgree(bool value) {
    emit(state.copyWith(isAgree: value));
  }

  Future<void> sendOtp() async {
    try {
      emit(state.copyWith(statusSendOtp: const LoadingState()));
      await authenticationRepository.sendOptDeleteAccount(
        requestData: RequestData(
          token: token,
          query: {'app-builder-decode': true},
          cancelToken: _cancelToken,
        ),
      );
      emit(state.copyWith(statusSendOtp: const LoadedState()));
    } on RequestError catch (e) {
      emit(state.copyWith(statusSendOtp: ErrorState(data: e)));
    }
  }

  Future<void> deleteAccount({required String otp}) async {
    try {
      emit(state.copyWith(status: const LoadingState()));
      Map<String, dynamic> data = await authenticationRepository.deleteAccount(
        requestData: RequestData(
          token: token,
          query: {
            'reason': state.reason?.name ?? '',
            'otp': otp,
            'app-builder-decode': true,
          },
          cancelToken: _cancelToken,
        ),
      );

      if (data['delete'] == true) {
        emit(state.copyWith(status: const LoadedState()));
      } else {
        emit(state.copyWith(status: ErrorState(data: RequestError(message: 'Fail'))));
      }
    } on RequestError catch (e) {
      emit(state.copyWith(status: ErrorState(data: e)));
    }
  }

  @override
  Future<void> close() {
    _cancelToken.cancel();
    return super.close();
  }
}
