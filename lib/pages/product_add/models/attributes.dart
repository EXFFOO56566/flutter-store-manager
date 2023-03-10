import 'package:formz/formz.dart';
import 'package:products_repository/products_repository.dart';

enum ListAttributeValidationError { empty }

class ListAttribute extends FormzInput<List<AttributeData>, ListAttributeValidationError> {
  const ListAttribute.pure() : super.pure(const []);

  const ListAttribute.dirty([List<AttributeData> value = const []]) : super.dirty(value);

  @override
  ListAttributeValidationError? validator(List<AttributeData>? value) {
    return null;
  }
}
