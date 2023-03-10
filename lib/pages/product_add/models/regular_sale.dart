
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:formz/formz.dart';

enum RegularPriceValidationError { empty, error }

class RegularPrice extends FormzInput<String, RegularPriceValidationError> {
  final String? type;

  const RegularPrice.pure({this.type, String value = ''}) : super.pure(value);

  const RegularPrice.dirty({this.type, String value = ''}) : super.dirty(value);

  @override
  RegularPriceValidationError? validator(String? value) {
    if (type != 'simple' && type != 'external') {
      return null;
    }

    if (value?.isNotEmpty != true) {
      return RegularPriceValidationError.empty;
    }

    if (!Validators.isNumeric(value)) {
      return RegularPriceValidationError.error;
    }
    return null;
  }
}
