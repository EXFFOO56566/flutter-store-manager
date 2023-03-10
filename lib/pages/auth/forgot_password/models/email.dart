import 'package:formz/formz.dart';

enum EmailValidationError { empty }

class EmailModel extends FormzInput<String, EmailValidationError> {
  const EmailModel.pure() : super.pure('');
  const EmailModel.dirty([String value = '']) : super.dirty(value);

  @override
  EmailValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : EmailValidationError.empty;
  }
}
