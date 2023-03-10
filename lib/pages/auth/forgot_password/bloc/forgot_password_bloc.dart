import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_store_manager/pages/auth/forgot_password/forgot_password.dart';
import 'package:formz/formz.dart';

part 'forgot_password_event.dart';

part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const ForgotPasswordState()) {
    on<ForgotPasswordUsernameChanged>(_onUsernameChanged);
    on<ForgotPasswordSubmitted>(_onSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onUsernameChanged(ForgotPasswordUsernameChanged event, Emitter<ForgotPasswordState> emit) {
    final email = EmailModel.dirty(event.email);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email]),
    ));
  }

  void _onSubmitted(ForgotPasswordSubmitted event, Emitter<ForgotPasswordState> emit) async {
    final email = EmailModel.dirty(state.email.value);

    FormzStatus status = Formz.validate([email]);

    if (status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        RequestData requestData = RequestData(data: {'user_login': state.email.value});
        await _authenticationRepository.forgotPassword(requestData: requestData);
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    } else {
      emit(state.copyWith(email: email, status: status));
    }
  }
}
