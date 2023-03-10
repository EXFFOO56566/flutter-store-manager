import 'package:json_annotation/json_annotation.dart';
import 'package:example/utils/utils.dart';
import 'time_report.dart';

part 'report.g.dart';

@JsonSerializable()
class ReportModel {
  @JsonKey(fromJson: toTimeReport, toJson: toDynamicToTimeReport)
  TimeReportModel data;

  @JsonKey(name: 'price_decimal', fromJson: toInt)
  int priceDecimal;

  String currency;

  ReportModel({
    required this.data,
    this.priceDecimal = 2,
    this.currency = 'USD',
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) => _$ReportModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReportModelToJson(this);

  static int toInt(dynamic value) {
    return ConvertData.stringToInt(value);
  }

  static TimeReportModel toTimeReport(dynamic value) {
    Map<String, dynamic> data = value is Map<String, dynamic> ? value : {};
    return TimeReportModel.fromJson(data);
  }

  static dynamic toDynamicToTimeReport(TimeReportModel value) {
    return value.toJson();
  }
}
