part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class UsernameChanged extends RegisterEvent {
  const UsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

class PasswordChanged extends RegisterEvent {
  const PasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class EmailChanged extends RegisterEvent {
  const EmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class FirstNameChanged extends RegisterEvent {
  const FirstNameChanged(this.firstName);

  final String firstName;

  @override
  List<Object> get props => [firstName];
}

class LastNameChanged extends RegisterEvent {
  const LastNameChanged(this.lastName);

  final String lastName;

  @override
  List<Object> get props => [lastName];
}

class RegisterSubmitted extends RegisterEvent {
  const RegisterSubmitted();
}

class RegisterChangeStatus extends RegisterEvent {
  const RegisterChangeStatus(this.status);

  final FormzStatus status;

  @override
  List<Object> get props => [status];
}
