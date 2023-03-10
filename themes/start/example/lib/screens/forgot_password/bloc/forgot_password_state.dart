part of 'forgot_password_bloc.dart';

class ForgotPasswordState extends Equatable {
  const ForgotPasswordState({
    this.status = FormzStatus.pure,
    this.email = const Email.pure(),
    this.errorMessage,
  });

  final FormzStatus status;
  final Email email;
  final String? errorMessage;

  ForgotPasswordState copyWith({
    FormzStatus? status,
    Email? email,
    String? errorMessage,
  }) {
    return ForgotPasswordState(
      status: status ?? this.status,
      email: email ?? this.email,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, email];
}
