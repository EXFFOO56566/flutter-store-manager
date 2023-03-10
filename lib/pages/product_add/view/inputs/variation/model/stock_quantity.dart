import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:formz/formz.dart';

enum StockQuantityValidationError { error }

class StockQuantity extends FormzInput<String?, StockQuantityValidationError> {
  final bool? manageStock;

  const StockQuantity.pure({this.manageStock, String? value}) : super.pure(value);
  const StockQuantity.dirty({this.manageStock, String? value}) : super.dirty(value);

  @override
  StockQuantityValidationError? validator(String? value) {
    // Stock quantity empty
    if (value == null || value == '') {
      return null;
    }
    if (manageStock == true && !Validators.isInt(value)) {
      return StockQuantityValidationError.error;
    }
    return null;
  }
}
