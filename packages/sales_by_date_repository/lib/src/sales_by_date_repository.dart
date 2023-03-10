// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Models
import 'package:sales_by_date_repository/src/models/legend_data.dart';
import 'package:sales_by_date_repository/src/models/order_chart.dart';

// Constants
import 'constants/constants.dart';

class SalesByDateRepository {
  final HttpClient _httpClient;

  SalesByDateRepository(this._httpClient);

  /// **Get chart sales by date**
  ///
  /// **Param:**
  ///
  /// requestData: your request data
  ///
  /// **Returns:**
  ///
  /// Return data as Map(
  /// chartModel: data['chart_model'],
  /// currency: data['currency'], priceDecimal: data['price_decimal'],
  /// legendData: data['legend_data')
  Future<Map<String, dynamic>> getChartByDate({required RequestData requestData}) async {
    try {
      var res = (await _httpClient.get(
        Endpoints.getChartByDate,
        data: requestData,
      )) as Map;
      Map<String, dynamic> result = {};
      OrderChartModel chart = OrderChartModel.fromJson(res['data'] ?? {});
      LegendData legendData = LegendData.fromJson(res['legend_data'] ?? {});
      result.addAll({
        "chart_model": chart,
        "currency": res['currency'],
        "price_decimal": res['price_decimal'],
        "legend_data": legendData
      });
      return result;
    } catch (_) {
      rethrow;
    }
  }
}
