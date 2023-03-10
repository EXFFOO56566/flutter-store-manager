import 'package:example/common/model/image_data.dart';
import 'package:formz/formz.dart';

enum ImageValidationError { empty }

class Image extends FormzInput<ImageData?, ImageValidationError> {
  const Image.pure() : super.pure(null);

  const Image.dirty(ImageData image) : super.dirty(image);

  @override
  ImageValidationError? validator(ImageData? value) {
    return null;
  }
}
