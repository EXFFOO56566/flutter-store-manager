import 'package:formz/formz.dart';

enum SoldIndividuallyValidationError { empty }

class SoldIndividually extends FormzInput<bool, SoldIndividuallyValidationError> {
  const SoldIndividually.pure([bool value = false]) : super.pure(value);
  const SoldIndividually.dirty([bool value = false]) : super.dirty(value);

  @override
  SoldIndividuallyValidationError? validator(bool? value) {
    return null;
  }
}
