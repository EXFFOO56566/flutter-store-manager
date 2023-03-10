part of 'register_bloc.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.status = FormzStatus.pure,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.email = const Email.pure(),
    this.firstName = const FirstName.pure(),
    this.lastName = const LastName.pure(),
    this.errorMessage,
    this.captcha = '',
    this.phrase = '',
  });

  final FormzStatus status;
  final Username username;
  final Password password;
  final Email email;
  final FirstName firstName;
  final LastName lastName;
  final String? errorMessage;
  final String captcha;
  final String phrase;

  RegisterState copyWith({
    FormzStatus? status,
    Username? username,
    Password? password,
    Email? email,
    FirstName? firstName,
    LastName? lastName,
    String? errorMessage,
    String? captcha,
    String? phrase,
  }) {
    return RegisterState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      errorMessage: errorMessage ?? this.errorMessage,
      captcha: captcha ?? this.captcha,
      phrase: phrase ?? this.phrase,
    );
  }

  @override
  List<Object> get props => [status, username, password, firstName, lastName, email, username, captcha, phrase];
}
