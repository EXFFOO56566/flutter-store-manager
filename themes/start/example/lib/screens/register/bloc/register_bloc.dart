// Bloc
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

// Form
import 'package:equatable/equatable.dart';
import 'package:example/mocks/auth_mock.dart';
import 'package:example/models/models.dart';
import 'package:formz/formz.dart';
import '../models/models.dart';

// Part
part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterState(user: UserModel())) {
    on<UsernameChanged>(_onUsernameChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<EmailChanged>(_onEmailChanged);
    on<FirstNameChanged>(_onFirstNameChanged);
    on<LastNameChanged>(_onLastNameNameChanged);
    on<RegisterSubmitted>(_onSubmitted);
    on<RegisterChangeStatus>(_onChangeStatus);
  }

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

  void _onSubmitted(RegisterSubmitted event, Emitter<RegisterState> emit) async {
    final username = Username.dirty(state.username.value);
    final password = Password.dirty(state.password.value);
    final email = Email.dirty(state.email.value);
    final firstName = FirstName.dirty(state.firstName.value);
    final lastName = LastName.dirty(state.lastName.value);

    FormzStatus status = Formz.validate([password, username, email, firstName, lastName]);

    if (status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        var data = await registerApi(
          email: state.email.value,
          firstName: state.firstName.value,
          lastName: state.lastName.value,
          username: state.username.value,
          password: state.password.value,
        );
        emit(state.copyWith(status: FormzStatus.submissionSuccess, user: UserModel.fromJson(data)));
      } on DioError catch (e) {
        emit(state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage: e.response != null && e.response?.data != null ? e.response?.data['message'] : e.message,
        ));
      }
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

  void _onChangeStatus(RegisterChangeStatus event, Emitter<RegisterState> emit) {
    emit(state.copyWith(status: event.status));
  }
}
