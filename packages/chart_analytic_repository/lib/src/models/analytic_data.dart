// Packages & Dependencies or Helper function
import 'package:json_annotation/json_annotation.dart';

part 'analytic_data.g.dart';

@JsonSerializable(createToJson: false)
class AnalyticData {
  final String name;
  final int count;

  AnalyticData({required this.name, required this.count});

  factory AnalyticData.fromJson(Map<String, dynamic> json) => _$AnalyticDataFromJson(json);
}
