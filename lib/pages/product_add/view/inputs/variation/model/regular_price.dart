import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:formz/formz.dart';

enum RegularPriceValidationError { empty, error }

class RegularPrice extends FormzInput<String, RegularPriceValidationError> {
  const RegularPrice.pure([String value = '']) : super.pure(value);
  const RegularPrice.dirty([String value = '']) : super.dirty(value);

  @override
  RegularPriceValidationError? validator(String? value) {
    if (value?.isNotEmpty != true) {
      return RegularPriceValidationError.empty;
    }

    if (!Validators.isNumeric(value)) {
      return RegularPriceValidationError.error;
    }
    return null;
  }
}
