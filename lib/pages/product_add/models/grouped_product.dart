import 'package:formz/formz.dart';

enum GroupedProductValidationError { empty }

class GroupedProduct extends FormzInput<List<int>, GroupedProductValidationError> {
  const GroupedProduct.pure() : super.pure(const []);

  const GroupedProduct.dirty([List<int> productIds = const []]) : super.dirty(productIds);

  @override
  GroupedProductValidationError? validator(List<int>? value) {
    return null;
  }
}
