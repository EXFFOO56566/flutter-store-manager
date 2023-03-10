part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginUsernameChanged extends LoginEvent {
  const LoginUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}
class LoginOpenCaptcha extends LoginEvent {
  final Function? openCaptcha;
  const LoginOpenCaptcha({this.openCaptcha});
}

class LoginChangeStatus extends LoginEvent {
  const LoginChangeStatus(this.status);

  final FormzStatus status;

  @override
  List<Object> get props => [status];
}

class LoginCaptchaChanged extends LoginEvent {
  const LoginCaptchaChanged(this.captcha,this.phrase);

  final String captcha;
  final String phrase;

  @override
  List<Object> get props => [captcha,phrase];
}
