// Packages & Dependencies or Helper function
import 'package:json_annotation/json_annotation.dart';

part 'order_chart.g.dart';

@JsonSerializable(createToJson: false)
class OrderChartModel {
  @JsonKey(name: 'order_counts')
  OrderChartData? orderCounts;

  @JsonKey(name: 'order_item_counts')
  OrderChartData? orderItemCounts;

  @JsonKey(name: 'shipping_amounts')
  OrderChartData? shippingAmounts;

  @JsonKey(name: 'total_tax')
  OrderChartData? taxAmounts;

  @JsonKey(name: 'total_earned_commission')
  OrderChartData? totalEarnedCommission;

  @JsonKey(name: 'total_paid_commission')
  OrderChartData? totalPaidCommission;

  @JsonKey(name: 'total_gross_sales')
  OrderChartData? totalGrossSales;

  @JsonKey(name: 'total_refund')
  OrderChartData? totalRefund;

  OrderChartModel(
      {this.orderCounts,
      this.orderItemCounts,
      this.shippingAmounts,
      this.taxAmounts,
      this.totalEarnedCommission,
      this.totalPaidCommission,
      this.totalGrossSales,
      this.totalRefund});

  factory OrderChartModel.fromJson(Map<String, dynamic> json) => _$OrderChartModelFromJson(json);
}

@JsonSerializable(
  createToJson: false,
)
class OrderChartData {
  List<String?>? labels;

  @JsonKey(name: 'datas')
  List<String?>? data;

  OrderChartData({this.labels, this.data});

  factory OrderChartData.fromJson(Map<String, dynamic> json) => _$OrderChartDataFromJson(json);
}
