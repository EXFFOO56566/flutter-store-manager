import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:formz/formz.dart';

enum SalePriceValidationError { error, regular }

class SalePrice extends FormzInput<String, SalePriceValidationError> {
  final String? regularPrice;

  const SalePrice.pure({this.regularPrice, String value = ''}) : super.pure(value);
  const SalePrice.dirty({this.regularPrice, String value = ''}) : super.dirty(value);

  @override
  SalePriceValidationError? validator(String? value) {
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
