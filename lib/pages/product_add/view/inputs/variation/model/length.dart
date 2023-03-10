import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:formz/formz.dart';

enum LengthValidationError { error }

class Length extends FormzInput<String, LengthValidationError> {
  const Length.pure([String value = '']) : super.pure(value);
  const Length.dirty([String value = '']) : super.dirty(value);

  @override
  LengthValidationError? validator(String? value) {
    // Height empty
    if (value == null || value == '') {
      return null;
    }

    if (!Validators.isNumeric(value)) {
      return LengthValidationError.error;
    }
    return null;
  }
}
