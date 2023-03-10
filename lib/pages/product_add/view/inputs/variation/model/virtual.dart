import 'package:formz/formz.dart';

enum VirtualValidationError { empty }

class Virtual extends FormzInput<bool, VirtualValidationError> {
  const Virtual.pure([bool value = false]) : super.pure(value);
  const Virtual.dirty([bool value = false]) : super.dirty(value);

  @override
  VirtualValidationError? validator(bool? value) {
    return null;
  }
}
