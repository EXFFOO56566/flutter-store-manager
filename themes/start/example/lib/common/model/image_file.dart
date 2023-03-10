import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ImageFile {
  String id;
  String path;

  ImageFile({
    required this.id,
    required this.path,
  });
}
