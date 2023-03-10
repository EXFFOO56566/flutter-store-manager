// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportModel _$ReportModelFromJson(Map<String, dynamic> json) => ReportModel(
      data: ReportModel.toTimeReport(json['data']),
      priceDecimal: json['price_decimal'] == null ? 2 : ReportModel.toInt(json['price_decimal']),
      currency: json['currency'] as String? ?? 'USD',
    );

Map<String, dynamic> _$ReportModelToJson(ReportModel instance) => <String, dynamic>{
      'data': ReportModel.toDynamicToTimeReport(instance.data),
      'price_decimal': instance.priceDecimal,
      'currency': instance.currency,
    };
