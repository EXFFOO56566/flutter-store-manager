import 'package:formz/formz.dart';

enum EmailModelValidationError { empty }
const String emailPattern = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"
    "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})";

class EmailModel extends FormzInput<String, EmailModelValidationError> {
  const EmailModel.pure([String value = '']) : super.pure(value);
  const EmailModel.dirty([String value = '']) : super.dirty(value);

  @override
  EmailModelValidationError? validator(String? value) {
    return RegExp(emailPattern).hasMatch(value!) ? null : EmailModelValidationError.empty;
  }
}
