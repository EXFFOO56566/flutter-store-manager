import 'package:formz/formz.dart';

enum ListVariationValidationError { empty, error }

class ListVariation extends FormzInput<List<int>, ListVariationValidationError> {
  const ListVariation.pure([List<int> value = const []]) : super.pure(value);

  const ListVariation.dirty([List<int> value = const []]) : super.dirty(value);

  @override
  ListVariationValidationError? validator(List<int>? value) {
    return null;
  }
}
