import 'package:formz/formz.dart';

enum ManagerStockValidationError { empty }

class ManagerStock extends FormzInput<bool, ManagerStockValidationError> {
  const ManagerStock.pure([bool value = false]) : super.pure(value);
  const ManagerStock.dirty([bool value = false]) : super.dirty(value);

  @override
  ManagerStockValidationError? validator(bool? value) {
    return null;
  }
}
