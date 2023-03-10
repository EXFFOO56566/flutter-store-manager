import 'package:json_annotation/json_annotation.dart';

part 'image_link.g.dart';

@JsonSerializable()
class ImageLink {
  int? id;
  String? name;
  String? src;

  ImageLink({
    required this.id,
    this.name,
    this.src,
  });

  factory ImageLink.fromJson(Map<String, dynamic> json) => _$ImageLinkFromJson(json);

  Map<String, dynamic> toJson() => _$ImageLinkToJson(this);
}
