import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:formz/formz.dart';

enum HeightValidationError { error }

class Height extends FormzInput<String, HeightValidationError> {
  const Height.pure([String value = '']) : super.pure(value);
  const Height.dirty([String value = '']) : super.dirty(value);

  @override
  HeightValidationError? validator(String? value) {
    // Height empty
    if (value == null || value == '') {
      return null;
    }

    if (!Validators.isNumeric(value)) {
      return HeightValidationError.error;
    }

    return null;
  }
}
