// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeReportModel _$TimeReportModelFromJson(Map<String, dynamic> json) => TimeReportModel(
      lastMonth: TimeReportModel.toStatModel(json['last_month']),
      month: TimeReportModel.toStatModel(json['month']),
      week: TimeReportModel.toStatModel(json['7day']),
      year: TimeReportModel.toStatModel(json['year']),
    );

Map<String, dynamic> _$TimeReportModelToJson(TimeReportModel instance) => <String, dynamic>{
      'last_month': TimeReportModel.toData(instance.lastMonth),
      'month': TimeReportModel.toData(instance.month),
      '7day': TimeReportModel.toData(instance.week),
      'year': TimeReportModel.toData(instance.year),
    };
