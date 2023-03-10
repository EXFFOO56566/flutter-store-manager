import 'package:formz/formz.dart';

import '../../default_attribute/default_attribute.dart';

enum ListAttributeValidationError { empty }

class ListAttribute extends FormzInput<List<DefaultAttributeData>, ListAttributeValidationError> {
  const ListAttribute.pure() : super.pure(const []);

  const ListAttribute.dirty([List<DefaultAttributeData> value = const []]) : super.dirty(value);

  @override
  ListAttributeValidationError? validator(List<DefaultAttributeData>? value) {
    return null;
  }
}
