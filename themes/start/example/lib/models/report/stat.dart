import 'package:example/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stat.g.dart';

@JsonSerializable()
class StatModel {
  @JsonKey(name: 'average_sales', fromJson: toDouble)
  double averageSales;

  @JsonKey(name: 'total_orders', fromJson: toInt)
  int totalOrders;

  @JsonKey(name: 'total_items', fromJson: toInt)
  int totalItems;

  @JsonKey(name: 'total_shipping', fromJson: toDouble)
  double totalShip;

  @JsonKey(name: 'total_earned', fromJson: toDouble)
  double totalEarn;

  @JsonKey(name: 'total_commission', fromJson: toDouble)
  double totalCommission;

  @JsonKey(name: 'gross_sales', fromJson: toDouble)
  double grossSales;

  @JsonKey(name: 'total_tax', fromJson: toDouble)
  double totalTax;

  @JsonKey(name: 'total_refund', fromJson: toDouble)
  double totalRefunds;

  StatModel({
    this.averageSales = 0,
    this.totalOrders = 0,
    this.totalItems = 0,
    this.totalShip = 0,
    this.totalEarn = 0,
    this.totalCommission = 0,
    this.grossSales = 0,
    this.totalTax = 0,
    this.totalRefunds = 0,
  });

  factory StatModel.fromJson(Map<String, dynamic> json) => _$StatModelFromJson(json);
  Map<String, dynamic> toJson() => _$StatModelToJson(this);

  static double toDouble(dynamic json) {
    return ConvertData.stringToDouble(json);
  }

  static int toInt(dynamic json) {
    return ConvertData.stringToInt(json);
  }
}
