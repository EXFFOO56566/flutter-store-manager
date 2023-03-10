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

class RegisterOpenCaptcha extends RegisterEvent {
  final Function? openCaptcha;
  const RegisterOpenCaptcha({this.openCaptcha});
}

class RegisterChangeStatus extends RegisterEvent {
  const RegisterChangeStatus(this.status);

  final FormzStatus status;

  @override
  List<Object> get props => [status];
}

class RegisterCaptchaChanged extends RegisterEvent {
  const RegisterCaptchaChanged(this.captcha, this.phrase);

  final String captcha;
  final String phrase;

  @override
  List<Object> get props => [captcha, phrase];
}
