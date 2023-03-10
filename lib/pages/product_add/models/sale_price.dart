import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:formz/formz.dart';

enum SalePriceValidationError { empty, regular, error }

class SalePrice extends FormzInput<String, SalePriceValidationError> {
  final String? type;
  final String? regularPrice;

  const SalePrice.pure({this.regularPrice, this.type, String value = ''}) : super.pure(value);

  const SalePrice.dirty({this.regularPrice, this.type, String value = ''}) : super.dirty(value);

  @override
  SalePriceValidationError? validator(String? value) {
    if (type != 'simple' && type != 'external') {
      return null;
    }

    // Sale price empty
    if (value == null || value == '' || !Validators.isNumeric(regularPrice)) {
      return null;
    }

    // Sale price not validate
    if (!Validators.isNumeric(value)) {
      return SalePriceValidationError.error;
    }

    // Sale price less than regular price
    if (regularPrice == null || regularPrice?.isEmpty == true || double.parse(regularPrice!) <= double.parse(value)) {
      return SalePriceValidationError.regular;
    }

    return null;
  }
}
