import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:formz/formz.dart';

enum WidthValidationError { error }

class Width extends FormzInput<String, WidthValidationError> {
  const Width.pure([String value = '']) : super.pure(value);
  const Width.dirty([String value = '']) : super.dirty(value);

  @override
  WidthValidationError? validator(String? value) {
    // Width empty
    if (value == null || value == '') {
      return null;
    }

    if (!Validators.isNumeric(value)) {
      return WidthValidationError.error;
    }
    return null;
  }
}
