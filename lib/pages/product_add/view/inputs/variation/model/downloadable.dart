import 'package:formz/formz.dart';

enum DownloadableValidationError { empty }

class Downloadable extends FormzInput<bool, DownloadableValidationError> {
  const Downloadable.pure([bool value = false]) : super.pure(value);
  const Downloadable.dirty([bool value = false]) : super.dirty(value);

  @override
  DownloadableValidationError? validator(bool? value) {
    return null;
  }
}
