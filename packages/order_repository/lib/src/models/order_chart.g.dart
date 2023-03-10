// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_chart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderChartModel _$OrderChartModelFromJson(Map<String, dynamic> json) => OrderChartModel(
      orderCounts:
          json['order_counts'] == null ? null : OrderChartData.fromJson(json['order_counts'] as Map<String, dynamic>),
      orderItemCounts: json['order_item_counts'] == null
          ? null
          : OrderChartData.fromJson(json['order_item_counts'] as Map<String, dynamic>),
      shippingAmounts: json['shipping_amounts'] == null
          ? null
          : OrderChartData.fromJson(json['shipping_amounts'] as Map<String, dynamic>),
      taxAmounts: json['total_tax'] == null ? null : OrderChartData.fromJson(json['total_tax'] as Map<String, dynamic>),
      totalEarnedCommission: json['total_earned_commission'] == null
          ? null
          : OrderChartData.fromJson(json['total_earned_commission'] as Map<String, dynamic>),
      totalPaidCommission: json['total_paid_commission'] == null
          ? null
          : OrderChartData.fromJson(json['total_paid_commission'] as Map<String, dynamic>),
      totalGrossSales: json['total_gross_sales'] == null
          ? null
          : OrderChartData.fromJson(json['total_gross_sales'] as Map<String, dynamic>),
      totalRefund:
          json['total_refund'] == null ? null : OrderChartData.fromJson(json['total_refund'] as Map<String, dynamic>),
    );

OrderChartData _$OrderChartDataFromJson(Map<String, dynamic> json) => OrderChartData(
      labels: (json['labels'] as List<dynamic>?)?.map((e) => e as String?).toList(),
      data: (json['datas'] as List<dynamic>?)?.map((e) => e as String?).toList(),
    );
