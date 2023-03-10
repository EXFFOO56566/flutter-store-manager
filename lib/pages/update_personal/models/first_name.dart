import 'package:formz/formz.dart';

enum FistNameValidationError { empty }

class FistName extends FormzInput<String, FistNameValidationError> {
  const FistName.pure([String value = '']) : super.pure(value);
  const FistName.dirty([String value = '']) : super.dirty(value);

  @override
  FistNameValidationError? validator(String? value) {
    return value?.isNotEmpty == true && value!.length > 2 ? null : FistNameValidationError.empty;
  }
}
