import 'package:appcheap_flutter_core/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';

import 'option_data.dart';

@JsonSerializable()
class AttributeData {
  int id;
  String key;
  String? name;
  bool visible;
  bool variation;
  OptionData option;

  AttributeData({
    required this.id,
    required this.key,
    this.name,
    this.visible = true,
    this.variation = true,
    required this.option,
  });

  factory AttributeData.fromJson(Map<String, dynamic> json) => _$AttributeDataTypeFromJson(json);

  Map<String, dynamic> toJson() => _$AttributeDataTypeToJson(this);

  @override
  String toString() => "$id - $name";
}

AttributeData _$AttributeDataTypeFromJson(Map<String, dynamic> json) {
  int id = ConvertData.stringToInt(json['id'] ?? '', 0);
  bool visible = json['visible'] is bool ? json['visible'] : true;
  bool variation = json['variation'] is bool ? json['variation'] : true;

  return AttributeData(
    id: id,
    key: StringGenerate.uuid(),
    name: json['name'] ?? '',
    visible: visible,
    variation: variation,
    option: OptionData.fromJson(
      json['options'] is List ? json['options'] : [],
      id == 0 ? OptionDataType.custom : OptionDataType.term,
    ),
  );
}

Map<String, dynamic> _$AttributeDataTypeToJson(AttributeData data) {
  return {
    'id': data.id,
    'name': data.name,
    'visible': data.visible,
    'variation': data.variation,
    'options': data.option.toJson(),
  };
}
