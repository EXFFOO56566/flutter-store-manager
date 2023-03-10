import 'package:formz/formz.dart';

enum ShippingClassValidationError { empty }

class ShippingClass extends FormzInput<String, ShippingClassValidationError> {
  const ShippingClass.pure([String value = '']) : super.pure(value);
  const ShippingClass.dirty([String value = '']) : super.dirty(value);

  @override
  ShippingClassValidationError? validator(String? value) {
    return null;
  }
}
