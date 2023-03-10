import 'package:formz/formz.dart';

enum ButtonTextValidationError { empty }

class ButtonText extends FormzInput<String, ButtonTextValidationError> {
  const ButtonText.pure([String value = '']) : super.pure(value);
  const ButtonText.dirty([String value = '']) : super.dirty(value);

  @override
  ButtonTextValidationError? validator(String? value) {
    return null;
  }
}
