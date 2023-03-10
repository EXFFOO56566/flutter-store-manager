import 'package:formz/formz.dart';

import '../view/inputs/default_attribute/default_attribute.dart';

enum ListDefaultAttributeValidationError { empty }

class ListDefaultAttribute extends FormzInput<List<DefaultAttributeData>, ListDefaultAttributeValidationError> {
  const ListDefaultAttribute.pure() : super.pure(const []);

  const ListDefaultAttribute.dirty([List<DefaultAttributeData> value = const []]) : super.dirty(value);

  @override
  ListDefaultAttributeValidationError? validator(List<DefaultAttributeData>? value) {
    return null;
  }
}
