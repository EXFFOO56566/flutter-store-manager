import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:example/mocks/mocks.dart';
import 'package:example/models/models.dart';
import 'package:formz/formz.dart';

import '../model/model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState(user: UserModel())) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

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

  void _onSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    final username = Username.dirty(state.username.value);
    final password = Password.dirty(state.password.value);

    FormzStatus status = Formz.validate([password, username]);

    if (status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        dynamic data = await loginApi(username.value, password.value);
        emit(state.copyWith(status: FormzStatus.submissionSuccess, user: UserModel.fromJson(data)));
      } on DioError catch (e) {
        emit(state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage: e.response != null && e.response?.data != null ? e.response?.data['message'] : e.message,
        ));
      }
    } else {
      emit(state.copyWith(username: username, password: password, status: status));
    }
  }
}
