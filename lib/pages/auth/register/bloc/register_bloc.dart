// Bloc
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
// Form
import 'package:equatable/equatable.dart';
import 'package:flutter_store_manager/constants/auth.dart';
import 'package:formz/formz.dart';
import '../models/models.dart';

// Part
part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const RegisterState()) {
    on<UsernameChanged>(_onUsernameChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<EmailChanged>(_onEmailChanged);
    on<FirstNameChanged>(_onFirstNameChanged);
    on<LastNameChanged>(_onLastNameNameChanged);
    on<RegisterSubmitted>(_onSubmitted);
    on<RegisterChangeStatus>(_onChangeStatus);
    on<RegisterCaptchaChanged>(_onChangeCaptcha);
    on<RegisterOpenCaptcha>(_onOpenCaptchaChanged);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onUsernameChanged(UsernameChanged event, Emitter<RegisterState> emit) {
    final username = Username.dirty(event.username);
    emit(state.copyWith(
      username: username,
      status: Formz.validate([state.password, username, state.email, state.firstName, state.lastName]),
    ));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<RegisterState> emit) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([password, state.username, state.email, state.firstName, state.lastName]),
    ));
  }

  void _onEmailChanged(EmailChanged event, Emitter<RegisterState> emit) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([state.password, state.username, email, state.firstName, state.lastName]),
    ));
  }

  void _onFirstNameChanged(FirstNameChanged event, Emitter<RegisterState> emit) {
    final firstName = FirstName.dirty(event.firstName);
    emit(state.copyWith(
      firstName: firstName,
      status: Formz.validate([state.password, state.username, state.email, firstName, state.lastName]),
    ));
  }

  void _onLastNameNameChanged(LastNameChanged event, Emitter<RegisterState> emit) {
    final lastName = LastName.dirty(event.lastName);
    emit(state.copyWith(
      lastName: lastName,
      status: Formz.validate([state.password, state.username, state.email, state.firstName, lastName]),
    ));
  }

  void _onChangeCaptcha(RegisterCaptchaChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(captcha: event.captcha, phrase: event.phrase));
  }

  void _onOpenCaptchaChanged(RegisterOpenCaptcha event, Emitter<RegisterState> emit) async {
    final username = Username.dirty(state.username.value);
    final password = Password.dirty(state.password.value);
    final email = Email.dirty(state.email.value);
    final firstName = FirstName.dirty(state.firstName.value);
    final lastName = LastName.dirty(state.lastName.value);

    FormzStatus status = Formz.validate([password, username, email, firstName, lastName]);

    if (status.isValidated) {
      await event.openCaptcha!();
    } else {
      emit(
        state.copyWith(
          username: username,
          password: password,
          email: email,
          firstName: firstName,
          lastName: lastName,
          status: status,
        ),
      );
    }
  }

  void _onSubmitted(RegisterSubmitted event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.register(
        requestData: RequestData(
          query: {
            'user_login': state.username.value,
            'password': state.password.value,
            'first_name': state.firstName.value,
            'last_name': state.lastName.value,
            'email': state.email.value,
            'agree_privacy_term': true,
            'role': userRole,
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

  void _onChangeStatus(RegisterChangeStatus event, Emitter<RegisterState> emit) {
    emit(state.copyWith(status: event.status));
  }
}
