import 'package:formz/formz.dart';

import 'package:flutter_store_manager/common/widgets/image/image.dart';

enum GalleryValidationError { empty }

class Gallery extends FormzInput<List<ImageData>?, GalleryValidationError> {
  const Gallery.pure() : super.pure(null);

  const Gallery.dirty(List<ImageData> images) : super.dirty(images);

  @override
  GalleryValidationError? validator(List<ImageData>? value) {
    return null;
  }
}
