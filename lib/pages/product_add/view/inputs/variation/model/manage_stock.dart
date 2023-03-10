import 'package:formz/formz.dart';

enum ManageStockValidationError { empty }

class ManageStock extends FormzInput<bool, ManageStockValidationError> {
  const ManageStock.pure([bool value = false]) : super.pure(value);
  const ManageStock.dirty([bool value = false]) : super.dirty(value);

  @override
  ManageStockValidationError? validator(bool? value) {
    return null;
  }
}
