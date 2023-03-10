// Packages & Dependencies or Helper function
import 'package:formz/formz.dart';

enum StoreNameValidationError { empty }

class StoreName extends FormzInput<String, StoreNameValidationError> {
  const StoreName.pure([String value = '']) : super.pure(value);
  const StoreName.dirty([String value = '']) : super.dirty(value);

  @override
  StoreNameValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : StoreNameValidationError.empty;
  }
}
