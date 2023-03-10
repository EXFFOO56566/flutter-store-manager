part of 'update_password_bloc.dart';

class UpdatePasswordState extends BaseState {
  final FormzStatus status;
  final Password oldPassword;
  final NewPassword newPassword;
  final ConfirmPassword confirmPassword;
  final String errorMessage;

  const UpdatePasswordState({
    this.status = FormzStatus.pure,
    this.oldPassword = const Password.pure(),
    this.newPassword = const NewPassword.pure(),
    this.confirmPassword = const ConfirmPassword.pure(),
    this.errorMessage = '',
  });

  @override
  List<Object?> get props => [
        status,
        oldPassword,
        newPassword,
        confirmPassword,
        errorMessage,
      ];
  UpdatePasswordState copyWith({
    FormzStatus? status,
    Password? oldPassword,
    NewPassword? newPassword,
    ConfirmPassword? confirmPassword,
    String? errorMessage,
  }) {
    return UpdatePasswordState(
      status: status ?? this.status,
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
