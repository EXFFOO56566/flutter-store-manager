// App core
import 'package:appcheap_flutter_core/utils/convert_data.dart';

// Models
import 'package:sales_by_date_repository/src/models/order_chart.dart';

class OrderChartMapped {
  OrderChartMapped(this.day, this.grossSale, this.earning, this.refunds, this.taxAmounts, this.shippingAmounts,
      this.orderCount, this.withdrawal);
  final String day;
  final double? grossSale;
  final double? earning;
  final double? refunds;
  final double? taxAmounts;
  final double? shippingAmounts;
  final double? orderCount;
  final double? withdrawal;
  static double max = 0;
  static double maxHomeChart = 0;

  static List<OrderChartMapped>? generateChartMapped({required OrderChartModel model}) {
    max = 0;
    maxHomeChart = 0;
    List<OrderChartMapped> list = [];
    if (model.totalGrossSales?.labels != null) {
      for (int i = 0; i < model.orderCounts!.labels!.length; i++) {
        //max
        if (max < ConvertData.stringToDouble(model.totalGrossSales?.data?[i])) {
          max = ConvertData.stringToDouble(model.totalGrossSales?.data?[i]);
        }
        if (maxHomeChart < ConvertData.stringToDouble(model.totalGrossSales?.data?[i])) {
          maxHomeChart = ConvertData.stringToDouble(model.totalGrossSales?.data?[i]);
        }
        if (max < ConvertData.stringToDouble(model.totalPaidCommission?.data?[i])) {
          max = ConvertData.stringToDouble(model.totalPaidCommission?.data?[i]);
        }
        //map
        OrderChartMapped orderChartMapped = OrderChartMapped(
          model.orderCounts!.labels![i]!,
          ConvertData.stringToDouble(model.totalGrossSales?.data?[i]),
          ConvertData.stringToDouble(model.totalEarnedCommission?.data?[i]),
          ConvertData.stringToDouble(model.totalRefund?.data?[i]),
          ConvertData.stringToDouble(model.taxAmounts?.data?[i]),
          ConvertData.stringToDouble(model.shippingAmounts?.data?[i]),
          ConvertData.stringToDouble(model.orderCounts?.data?[i]),
          ConvertData.stringToDouble(model.totalPaidCommission?.data?[i]),
        );
        list.add(orderChartMapped);
      }
      max = max + (max / 10);
      maxHomeChart = maxHomeChart + (maxHomeChart / 5);
      return list;
    }
    return null;
  }

  @override
  String toString() {
    return "label: $day gross: $grossSale earn: $earning"
        " refund: $refunds tax: $taxAmounts";
  }
}
