part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = FormzStatus.pure,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.errorMessage,
    this.captcha,
    this.phrase,
  });

  final FormzStatus status;
  final Username username;
  final Password password;
  final String? errorMessage;
  final String? captcha;
  final String? phrase;

  LoginState copyWith({
    FormzStatus? status,
    Username? username,
    Password? password,
    String? errorMessage,
    String? captcha,
    String? phrase,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      errorMessage: errorMessage ?? this.errorMessage,
      captcha: captcha ?? this.captcha,
      phrase: phrase ?? this.phrase,
    );
  }

  @override
  List<Object?> get props => [status, username, password, captcha, phrase];
}
