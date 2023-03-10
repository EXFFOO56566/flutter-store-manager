import 'package:category_repository/category_repository.dart';
import 'package:formz/formz.dart';

enum ListCategoryValidationError { empty }

class ListCategory extends FormzInput<List<Category>, ListCategoryValidationError> {
  const ListCategory.pure() : super.pure(const []);

  const ListCategory.dirty([List<Category> value = const []]) : super.dirty(value);

  @override
  ListCategoryValidationError? validator(List<Category>? value) {
    return null;
  }
}
