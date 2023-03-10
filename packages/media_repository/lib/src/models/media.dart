// Packages & Dependencies or Helper function
import 'package:json_annotation/json_annotation.dart';

part 'media.g.dart';

@JsonSerializable(createToJson: false)
class Media {
  Media({required this.id, this.url});

  final int id;

  @JsonKey(name: 'source_url')
  String? url;

  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);
}
