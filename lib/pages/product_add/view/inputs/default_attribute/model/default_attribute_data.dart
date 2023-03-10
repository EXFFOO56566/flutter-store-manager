import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class DefaultAttributeData {
  int id;
  String name;
  String? option;

  DefaultAttributeData({
    required this.id,
    this.name = '',
    this.option,
  });

  factory DefaultAttributeData.fromJson(Map<String, dynamic> json) => _$DefaultAttributeDataFromJson(json);

  Map<String, dynamic> toJson() => _$DefaultAttributeDataTypeToJson(this);

  @override
  String toString() => "$id =- $name";
}

DefaultAttributeData _$DefaultAttributeDataFromJson(Map<String, dynamic> json) {
  int id = ConvertData.stringToInt(json['id'] ?? '', 0);

  return DefaultAttributeData(
    id: id,
    name: (json['name'] ?? '') as String,
    option: json['option'] as String?,
  );
}

Map<String, dynamic> _$DefaultAttributeDataTypeToJson(DefaultAttributeData data) {
  return {
    'id': data.id,
    'name': data.name,
    'option': data.option,
  };
}
