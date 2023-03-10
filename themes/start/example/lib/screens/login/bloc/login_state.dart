part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    required this.user,
    this.status = FormzStatus.pure,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.errorMessage,
  });

  final FormzStatus status;
  final Username username;
  final Password password;
  final String? errorMessage;
  final UserModel user;

  LoginState copyWith({
    FormzStatus? status,
    Username? username,
    Password? password,
    String? errorMessage,
    UserModel? user,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
    );
  }

  @override
  List<Object> get props => [status, username, password, user];
}
