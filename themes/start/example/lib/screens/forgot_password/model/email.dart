import 'package:example/utils/utils.dart';
import 'package:formz/formz.dart';

enum EmailValidationError { empty, noEmail }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([String value = '']) : super.dirty(value);

  @override
  EmailValidationError? validator(String? value) {
    if (value?.isNotEmpty != true) {
      return EmailValidationError.empty;
    }
    if (!ValidateField.emailValidator(value: value!)) {
      return EmailValidationError.noEmail;
    }
    return null;
  }
}
