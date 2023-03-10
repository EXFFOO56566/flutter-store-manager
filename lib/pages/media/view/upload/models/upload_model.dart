import 'package:json_annotation/json_annotation.dart';

part 'upload_model.g.dart';

@JsonSerializable(createToJson: false)
class UploadModel {
  String id;
  String? path;

  UploadModel({
    required this.id,
    this.path,
  });
  factory UploadModel.fromJson(Map<String, dynamic> json) => _$UploadModelFromJson(json);
}
