class LegendData {
  String? averageSales;
  int? totalOrders;
  int? totalItems;
  String? totalShipping;
  String? totalEarned;
  String? totalCommission;
  String? grossSales;
  String? totalTax;
  String? totalRefund;

  LegendData(
      {this.averageSales,
      this.totalOrders,
      this.totalItems,
      this.totalShipping,
      this.totalEarned,
      this.totalCommission,
      this.grossSales,
      this.totalTax,
      this.totalRefund});

  LegendData.fromJson(Map<String, dynamic> json) {
    averageSales = json['average_sales'].toString();
    totalOrders = json['total_orders'];
    totalItems = json['total_items'];
    totalShipping = json['total_shipping'].toString();
    totalEarned = json['total_earned'].toString();
    totalCommission = json['total_commission'].toString();
    grossSales = json['gross_sales'].toString();
    totalTax = json['total_tax'].toString();
    totalRefund = json['total_refund'].toString();
  }
}
