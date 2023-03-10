import 'package:formz/formz.dart';

enum PhoneValidationError { empty }

class PersonalPhone extends FormzInput<String, PhoneValidationError> {
  const PersonalPhone.pure([String value = '']) : super.pure(value);
  const PersonalPhone.dirty([String value = '']) : super.dirty(value);

  @override
  PhoneValidationError? validator(String? value) {
    return null;
  }
}
