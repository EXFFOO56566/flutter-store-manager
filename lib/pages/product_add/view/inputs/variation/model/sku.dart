import 'package:formz/formz.dart';

enum SkuValidationError { empty }

class Sku extends FormzInput<String, SkuValidationError> {
  const Sku.pure([String value = '']) : super.pure(value);
  const Sku.dirty([String value = '']) : super.dirty(value);

  @override
  SkuValidationError? validator(String? value) {
    return null;
  }
}
