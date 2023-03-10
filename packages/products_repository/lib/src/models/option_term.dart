import 'package:appcheap_flutter_core/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class OptionTerm {
  int id;

  String? name;
  String? slug;

  OptionTerm({
    required this.id,
    this.name,
    this.slug,
  });

  factory OptionTerm.fromJson(Map<String, dynamic> json) => _$OptionTermTypeFromJson(json);

  Map<String, dynamic> toJson() => _$OptionTermTypeToJson(this);

  @override
  String toString() => "$id - $name";
}

OptionTerm _$OptionTermTypeFromJson(Map<String, dynamic> json) {
  int id = ConvertData.stringToInt(json['term_id'] ?? '', 0);

  return OptionTerm(
    id: id,
    name: json['name'] ?? '',
    slug: json['slug'] ?? '',
  );
}

Map<String, dynamic> _$OptionTermTypeToJson(OptionTerm data) {
  return {
    "term_id": data.id,
    "name": data.name,
    "slug": data.slug,
  };
}
