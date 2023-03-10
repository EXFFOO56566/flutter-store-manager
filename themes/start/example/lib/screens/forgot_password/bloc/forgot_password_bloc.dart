import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:example/mocks/auth_mock.dart';
import 'package:formz/formz.dart';

import '../model/email.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(const ForgotPasswordState()) {
    on<ForgotPasswordEmailChanged>(_onEmailChanged);
    on<ForgotPasswordSubmitted>(_onSubmitted);
  }

  void _onEmailChanged(ForgotPasswordEmailChanged event, Emitter<ForgotPasswordState> emit) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email]),
    ));
  }

  void _onSubmitted(ForgotPasswordSubmitted event, Emitter<ForgotPasswordState> emit) async {
    final email = Email.dirty(state.email.value);

    FormzStatus status = Formz.validate([email]);

    if (status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await forgotPasswordApi(email.value);
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } on DioError catch (e) {
        emit(state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage: e.response != null && e.response?.data != null ? e.response?.data['message'] : e.message,
        ));
      }
    } else {
      emit(state.copyWith(email: email, status: status));
    }
  }
}
