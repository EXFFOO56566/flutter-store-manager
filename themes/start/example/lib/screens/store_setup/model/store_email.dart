import 'package:example/utils/utils.dart';
import 'package:formz/formz.dart';

enum StoreEmailValidationError { empty, invalidFormat }

class StoreEmail extends FormzInput<String, StoreEmailValidationError> {
  const StoreEmail.pure([String value = '']) : super.pure(value);
  const StoreEmail.dirty([String value = '']) : super.dirty(value);

  @override
  StoreEmailValidationError? validator(String? value) {
    if (value != null) {
      if (value.isNotEmpty) {
        if (ValidateField.emailValidator(value: value)) {
          return null;
        } else {
          return StoreEmailValidationError.invalidFormat;
        }
      } else {
        StoreEmailValidationError.empty;
      }
    }
    return StoreEmailValidationError.empty;
  }
}
