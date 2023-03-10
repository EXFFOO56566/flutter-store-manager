// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Constants
import 'constants/constants.dart';

// Models
import 'models/models.dart';

class SaleProductRepository {
  final HttpClient _httpClient;

  SaleProductRepository(this._httpClient);

  /// Get data sale product
  ///
  /// Throws an [Error] if client not get data. Returns list data sale product.
  Future<List<SaleProduct>> getSaleProduct({required RequestData requestData}) async {
    try {
      dynamic res = await _httpClient.get(
        Endpoints.getChartSeller,
        data: requestData,
      );
      List<SaleProduct> data = List<SaleProduct>.of([]);
      if (res is Map && res['labels'] is List && res['datas'] is List) {
        int count = res['labels'].length > res['datas'].length ? res['labels'].length : res['datas'].length;
        if (count > 0) {
          for (int i = 0; i < count; i++) {
            SaleProduct p = SaleProduct(
              count: ConvertData.stringToInt(res['datas']?[i] ?? 0),
              name: res['labels'][i] ?? '',
            );
            data.add(p);
          }
        }
      }
      return data;
    } catch (_) {
      rethrow;
    }
  }
}
