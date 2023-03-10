part of 'forgot_password_bloc.dart';

class ForgotPasswordState extends Equatable {
  const ForgotPasswordState({
    this.status = FormzStatus.pure,
    this.email = const EmailModel.pure(),
  });

  final FormzStatus status;
  final EmailModel email;

  ForgotPasswordState copyWith({
    FormzStatus? status,
    EmailModel? email,
  }) {
    return ForgotPasswordState(
      status: status ?? this.status,
      email: email ?? this.email,
    );
  }

  @override
  List<Object> get props => [status, email];
}
