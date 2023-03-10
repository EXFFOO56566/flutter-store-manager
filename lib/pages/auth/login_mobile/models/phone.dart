import 'package:flutter_store_manager/themes.dart';
import 'package:formz/formz.dart';

enum PhoneValidationError { empty }

class Phone extends FormzInput<PhoneNumber?, PhoneValidationError> {
  const Phone.pure() : super.pure(null);
  const Phone.dirty(PhoneNumber value) : super.dirty(value);

  @override
  PhoneValidationError? validator(PhoneNumber? value) {
    if (value != null && value.completeNumber != '') {
      return null;
    }
    return PhoneValidationError.empty;
  }
}
