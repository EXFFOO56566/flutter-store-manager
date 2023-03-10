// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportStats _$ReportStatsFromJson(Map<String, dynamic> json) => ReportStats(
      data: json['data'] == null ? null : ReportStatsData.fromJson(json['data'] as Map<String, dynamic>),
      priceDecimal: json['price_decimal'] as String?,
      currency: json['currency'] as String?,
    );

Map<String, dynamic> _$ReportStatsToJson(ReportStats instance) => <String, dynamic>{
      'data': instance.data,
      'price_decimal': instance.priceDecimal,
      'currency': instance.currency,
    };

ReportStatsData _$ReportStatsDataFromJson(Map<String, dynamic> json) => ReportStatsData(
      lastMonth: json['last_month'] == null ? null : Stats.fromJson(json['last_month'] as Map<String, dynamic>),
      month: json['month'] == null ? null : Stats.fromJson(json['month'] as Map<String, dynamic>),
      week: json['7day'] == null ? null : Stats.fromJson(json['7day'] as Map<String, dynamic>),
      year: json['year'] == null ? null : Stats.fromJson(json['year'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReportStatsDataToJson(ReportStatsData instance) => <String, dynamic>{
      'last_month': instance.lastMonth,
      'month': instance.month,
      '7day': instance.week,
      'year': instance.year,
    };

Stats _$StatsFromJson(Map<String, dynamic> json) => Stats(
      averageSales: Stats.toDouble(json['average_sales']),
      totalOrders: json['total_orders'] as int?,
      totalItems: json['total_items'] as int?,
      totalShip: Stats.toDouble(json['total_shipping']),
      totalEarn: Stats.toDouble(json['total_earned']),
      totalCommission: Stats.toDouble(json['total_commission']),
      grossSales: Stats.toDouble(json['gross_sales']),
      totalTax: Stats.toDouble(json['total_tax']),
      totalRefunds: Stats.toDouble(json['total_refund']),
    );

Map<String, dynamic> _$StatsToJson(Stats instance) => <String, dynamic>{
      'average_sales': instance.averageSales,
      'total_orders': instance.totalOrders,
      'total_items': instance.totalItems,
      'total_shipping': instance.totalShip,
      'total_earned': instance.totalEarn,
      'total_commission': instance.totalCommission,
      'gross_sales': instance.grossSales,
      'total_tax': instance.totalTax,
      'total_refund': instance.totalRefunds,
    };
