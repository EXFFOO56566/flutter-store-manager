import 'package:formz/formz.dart';

enum BackordersValidationError { empty }

class Backorders extends FormzInput<String, BackordersValidationError> {
  const Backorders.pure([String value = 'no']) : super.pure(value);
  const Backorders.dirty([String value = 'no']) : super.dirty(value);

  @override
  BackordersValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : BackordersValidationError.empty;
  }
}
