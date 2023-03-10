import 'package:json_annotation/json_annotation.dart';

import 'option_term.dart';

enum OptionDataType { custom, term }

@JsonSerializable()
class OptionData {
  OptionDataType type;
  String custom;
  List<OptionTerm> term;

  OptionData({
    required this.type,
    this.custom = '',
    this.term = const [],
  });

  factory OptionData.fromJson(List json, [OptionDataType initType = OptionDataType.custom]) =>
      _$OptionDataTypeFromJson(json, initType);

  List toJson() => _$OptionDataTypeToJson(this);

  @override
  String toString() => "$type";
}

OptionData _$OptionDataTypeFromJson(List json, [OptionDataType initType = OptionDataType.custom]) {
  OptionDataType type = json.isNotEmpty && json.first is Map ? OptionDataType.term : initType;
  List<String> arrCustom =
      type == OptionDataType.custom && json.isNotEmpty && json.first is String ? json.cast<String>() : [];

  String custom = arrCustom.join(' | ');

  List<OptionTerm> term = type == OptionDataType.term
      ? json.map((e) => OptionTerm.fromJson(e is Map<String, dynamic> ? e : {})).toList()
      : [];

  return OptionData(
    type: type,
    custom: custom,
    term: term,
  );
}

List _$OptionDataTypeToJson(OptionData data) {
  if (data.type == OptionDataType.custom) {
    return data.custom.split('|').map((e) => e.trim()).toList();
  }

  return data.term.map((e) => e.name ?? '').toList();
}
