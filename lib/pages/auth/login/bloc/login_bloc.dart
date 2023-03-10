import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_store_manager/pages/auth/login/login.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
    on<LoginChangeStatus>(_onChangeStatus);
    on<LoginCaptchaChanged>(_onChangeCaptcha);
    on<LoginOpenCaptcha>(_onOpenCaptchaChanged);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onUsernameChanged(LoginUsernameChanged event, Emitter<LoginState> emit) {
    final username = Username.dirty(event.username);
    emit(state.copyWith(
      username: username,
      status: Formz.validate([state.password, username]),
    ));
  }

  void _onPasswordChanged(LoginPasswordChanged event, Emitter<LoginState> emit) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([password, state.username]),
    ));
  }

  void _onChangeCaptcha(LoginCaptchaChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(captcha: event.captcha, phrase: event.phrase));
  }

  void _onOpenCaptchaChanged(LoginOpenCaptcha event, Emitter<LoginState> emit) async {
    final username = Username.dirty(state.username.value);
    final password = Password.dirty(state.password.value);

    FormzStatus status = Formz.validate([password, username]);

    if (status.isValidated) {
      await event.openCaptcha!();
    } else {
      emit(state.copyWith(username: username, password: password, status: status));
    }
  }

  void _onSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.logIn(
        requestData: RequestData(
          query: {
            'username': state.username.value,
            'password': state.password.value,
            'captcha': state.captcha,
            'phrase': state.phrase,
          },
        ),
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on RequestError catch (e) {
      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
        errorMessage: e.message,
      ));
    }
  }

  void _onChangeStatus(LoginChangeStatus event, Emitter<LoginState> emit) {
    emit(state.copyWith(status: event.status));
  }
}
