import 'package:formz/formz.dart';

enum CatalogVisibilityValidationError { empty }

class CatalogVisibility extends FormzInput<String, CatalogVisibilityValidationError> {
  const CatalogVisibility.pure([String value = 'visible']) : super.pure(value);
  const CatalogVisibility.dirty([String value = 'visible']) : super.dirty(value);

  @override
  CatalogVisibilityValidationError? validator(String? value) {
    return null;
  }
}
