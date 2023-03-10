import 'package:json_annotation/json_annotation.dart';

import 'image_link.dart';
import 'image_file.dart';

enum ImageDataType { image, file }

@JsonSerializable()
class ImageData {
  ImageDataType type;
  ImageLink? image;
  ImageFile? file;

  ImageData({
    required this.type,
    this.image,
    this.file,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) => _$ImageDataTypeFromJson(json);

  @override
  String toString() => "${image?.id ?? file?.id}";
}

ImageData _$ImageDataTypeFromJson(Map<String, dynamic> json) => ImageData(
      type: ImageDataType.image,
      image: ImageLink.fromJson(json),
    );
