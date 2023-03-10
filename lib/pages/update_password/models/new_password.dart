import 'package:formz/formz.dart';

enum NewPasswordValidationError { empty, same }

class NewPassword extends FormzInput<String, NewPasswordValidationError> {
  final String? oldPassword;

  const NewPassword.pure({this.oldPassword, String value = ''}) : super.pure(value);
  const NewPassword.dirty({this.oldPassword, String value = ''}) : super.dirty(value);

  @override
  NewPasswordValidationError? validator(String? value) {
    if (value?.isNotEmpty != true) {
      return NewPasswordValidationError.empty;
    }

    if (oldPassword?.isNotEmpty == true && value == oldPassword) {
      return NewPasswordValidationError.same;
    }

    return null;
  }
}
