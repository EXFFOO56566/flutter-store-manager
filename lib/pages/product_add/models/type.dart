import 'package:formz/formz.dart';

enum TypeValidationError { empty }

const defaultType = 'simple';

class Type extends FormzInput<String, TypeValidationError> {
  const Type.pure() : super.pure('');
  const Type.dirty([String value = defaultType]) : super.dirty(value);

  @override
  TypeValidationError? validator(String value) {
    return null;
  }
}
