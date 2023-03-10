import 'package:formz/formz.dart';

enum ConfirmPasswordValidationError { empty, diff }

class ConfirmPassword extends FormzInput<String, ConfirmPasswordValidationError> {
  final String? newPassword;

  const ConfirmPassword.pure({this.newPassword, String value = ''}) : super.pure(value);
  const ConfirmPassword.dirty({this.newPassword, String value = ''}) : super.dirty(value);

  @override
  ConfirmPasswordValidationError? validator(String? value) {
    if (value?.isNotEmpty != true) {
      return ConfirmPasswordValidationError.empty;
    }
    if (newPassword?.isNotEmpty == true && value != newPassword) {
      return ConfirmPasswordValidationError.diff;
    }
    return null;
  }
}
