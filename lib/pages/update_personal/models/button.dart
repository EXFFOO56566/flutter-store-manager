import 'package:formz/formz.dart';

enum PersonalButtonValidationError { empty }

class PersonalButton extends FormzInput<String, PersonalButtonValidationError> {
  const PersonalButton.pure([String value = '']) : super.pure(value);
  const PersonalButton.dirty([String value = '']) : super.dirty(value);

  @override
  PersonalButtonValidationError? validator(String? value) {
    return null;
  }
}
