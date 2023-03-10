import 'package:json_annotation/json_annotation.dart';
import 'stat.dart';

part 'time_report.g.dart';

@JsonSerializable()
class TimeReportModel {
  @JsonKey(name: 'last_month', fromJson: toStatModel, toJson: toData)
  StatModel lastMonth;

  @JsonKey(fromJson: toStatModel, toJson: toData)
  StatModel month;

  @JsonKey(name: '7day', fromJson: toStatModel, toJson: toData)
  StatModel week;

  @JsonKey(fromJson: toStatModel, toJson: toData)
  StatModel year;

  TimeReportModel({
    required this.lastMonth,
    required this.month,
    required this.week,
    required this.year,
  });

  factory TimeReportModel.fromJson(Map<String, dynamic> json) => _$TimeReportModelFromJson(json);
  Map<String, dynamic> toJson() => _$TimeReportModelToJson(this);

  static StatModel toStatModel(dynamic value) {
    Map<String, dynamic> data = value is Map<String, dynamic> ? value : {};
    return StatModel.fromJson(data);
  }

  static dynamic toData(StatModel value) {
    return value.toJson();
  }
}
