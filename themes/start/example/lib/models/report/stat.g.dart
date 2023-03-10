// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatModel _$StatModelFromJson(Map<String, dynamic> json) => StatModel(
      averageSales: json['average_sales'] == null ? 0 : StatModel.toDouble(json['average_sales']),
      totalOrders: json['total_orders'] == null ? 0 : StatModel.toInt(json['total_orders']),
      totalItems: json['total_items'] == null ? 0 : StatModel.toInt(json['total_items']),
      totalShip: json['total_shipping'] == null ? 0 : StatModel.toDouble(json['total_shipping']),
      totalEarn: json['total_earned'] == null ? 0 : StatModel.toDouble(json['total_earned']),
      totalCommission: json['total_commission'] == null ? 0 : StatModel.toDouble(json['total_commission']),
      grossSales: json['gross_sales'] == null ? 0 : StatModel.toDouble(json['gross_sales']),
      totalTax: json['total_tax'] == null ? 0 : StatModel.toDouble(json['total_tax']),
      totalRefunds: json['total_refund'] == null ? 0 : StatModel.toDouble(json['total_refund']),
    );

Map<String, dynamic> _$StatModelToJson(StatModel instance) => <String, dynamic>{
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
