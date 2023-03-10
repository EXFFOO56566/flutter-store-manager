import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:formz/formz.dart';

enum WeightValidationError { error }

class Weight extends FormzInput<String, WeightValidationError> {
  const Weight.pure([String value = '']) : super.pure(value);
  const Weight.dirty([String value = '']) : super.dirty(value);

  @override
  WeightValidationError? validator(String? value) {
    // Height empty
    if (value == null || value == '') {
      return null;
    }

    if (!Validators.isNumeric(value)) {
      return WeightValidationError.error;
    }
    return null;
  }
}
