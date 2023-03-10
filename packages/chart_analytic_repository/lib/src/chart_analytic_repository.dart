// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Models
import 'package:chart_analytic_repository/src/models/analytic_data.dart';

// Constants
import 'constants/constants.dart';

class ChartAnalyticRepository {
  final HttpClient _httpClient;

  ChartAnalyticRepository(this._httpClient);

  /// **Get chart analytic**
  ///
  /// **Param:**
  ///
  /// requestData: your request data
  ///
  /// **Returns:**
  ///
  /// Return chart analytic data as List<AnalyticData>
  Future<List<AnalyticData>> getChartAnalytic({required RequestData requestData}) async {
    try {
      var data = (await _httpClient.get(
        Endpoints.getChartAnalytic,
        data: requestData,
      )) as Map;
      dynamic labels = data['labels'] ?? [];
      dynamic datas = data['datas'] ?? [];

      final List<AnalyticData> results = [];

      if (labels is List && datas is List) {
        for (int i = 0; i < labels.length; i++) {
          results.add(AnalyticData.fromJson({
            'name': labels[i],
            'count': ConvertData.stringToInt(datas[i] ?? 0, 0),
          }));
        }
      }
      return results;
    } catch (_) {
      rethrow;
    }
  }
}
