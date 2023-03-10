// Packages & Dependencies or Helper function
import 'package:json_annotation/json_annotation.dart';

part 'state.g.dart';

@JsonSerializable(createToJson: false)
class StateData {
  String code;
  String name;

  StateData({
    required this.code,
    required this.name,
  });

  factory StateData.fromJson(Map<String, dynamic> json) => _$StateDataFromJson(json);
  Map<String, dynamic> toJson() => _$StateDataToJson(this);
}
