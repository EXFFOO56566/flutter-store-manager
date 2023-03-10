import 'package:formz/formz.dart';

enum StockStatusValidationError { empty }

class StockStatus extends FormzInput<String, StockStatusValidationError> {
  const StockStatus.pure([String value = 'instock']) : super.pure(value);
  const StockStatus.dirty([String value = 'instock']) : super.dirty(value);

  @override
  StockStatusValidationError? validator(String? value) {
    return null;
  }
}
