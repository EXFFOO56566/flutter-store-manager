import 'package:formz/formz.dart';

import 'package:flutter_store_manager/common/widgets/image/image.dart';

enum ImagePersonalValidationError { empty }

class ImagePersonal extends FormzInput<ImageData?, ImagePersonalValidationError> {
  const ImagePersonal.pure() : super.pure(null);

  const ImagePersonal.dirty(ImageData image) : super.dirty(image);

  @override
  ImagePersonalValidationError? validator(ImageData? value) {
    return null;
  }
}
