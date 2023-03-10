import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';

import 'package:formz/formz.dart';
import 'package:authentication_repository/authentication_repository.dart';

import '../models/models.dart';

part 'update_password_event.dart';
part 'update_password_state.dart';

class UpdatePasswordBloc extends Bloc<UpdatePasswordEvent, UpdatePasswordState> {
  final AuthenticationRepository authenticationRepository;
  final RequestCancel _cancelToken = RequestCancel();
  final String token;

  UpdatePasswordBloc({
    required this.authenticationRepository,
    required this.token,
  }) : super(const UpdatePasswordState()) {
    on<OldPasswordChanged>(_onOldPasswordChanged);
    on<NewPasswordChanged>(_onNewPasswordChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<Submitted>(_onSubmit);
  }

  void _onOldPasswordChanged(OldPasswordChanged event, Emitter<UpdatePasswordState> emit) {
    Password oldPassword = Password.dirty(event.value);

    String valueNew = state.newPassword.value;
    NewPassword newPassword =
        valueNew.isNotEmpty ? NewPassword.dirty(oldPassword: event.value, value: valueNew) : state.newPassword;

    emit(state.copyWith(
      oldPassword: oldPassword,
      newPassword: newPassword,
      status: Formz.validate([oldPassword, newPassword]),
    ));
  }

  void _onNewPasswordChanged(NewPasswordChanged event, Emitter<UpdatePasswordState> emit) {
    NewPassword newPassword = NewPassword.dirty(oldPassword: state.oldPassword.value, value: event.value);

    String valueConfirm = state.confirmPassword.value;
    ConfirmPassword confirmPassword = valueConfirm.isNotEmpty
        ? ConfirmPassword.dirty(newPassword: event.value, value: valueConfirm)
        : state.confirmPassword;

    emit(state.copyWith(
      newPassword: newPassword,
      confirmPassword: confirmPassword,
      status: Formz.validate([newPassword, confirmPassword]),
    ));
  }

  void _onConfirmPasswordChanged(ConfirmPasswordChanged event, Emitter<UpdatePasswordState> emit) {
    final confirmPassword = ConfirmPassword.dirty(newPassword: state.newPassword.value, value: event.value);
    emit(state.copyWith(
      confirmPassword: confirmPassword,
      status: Formz.validate([confirmPassword]),
    ));
  }

  void _onSubmit(Submitted event, Emitter<UpdatePasswordState> emit) async {
    final oldPassword = Password.dirty(state.oldPassword.value);
    final newPassword = NewPassword.dirty(oldPassword: state.oldPassword.value, value: state.newPassword.value);
    final confirmPassword =
        ConfirmPassword.dirty(newPassword: state.newPassword.value, value: state.confirmPassword.value);

    FormzStatus status = Formz.validate([oldPassword, newPassword, confirmPassword]);
    if (status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      try {
        final data = {
          'password_old': state.oldPassword.value,
          'password_new': state.newPassword.value,
        };

        await authenticationRepository.changePassword(
            requestData: RequestData(
          data: data,
          query: {'app-builder-decode': true},
          token: token,
        ));
        emit(state.copyWith(
          status: FormzStatus.submissionSuccess,
        ));
      } on RequestError catch (e) {
        emit(state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage: e.message,
        ));
      }
    } else {
      emit(state.copyWith(
        oldPassword: oldPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
        status: status,
      ));
    }
  }

  @override
  Future<void> close() {
    _cancelToken.cancel();
    return super.close();
  }
}
