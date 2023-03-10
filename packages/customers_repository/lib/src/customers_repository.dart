// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Constants
import 'constants/constants.dart';

class CustomersRepository {
  final HttpClient _httpClient;
  CustomersRepository(this._httpClient);

  /// **Get customer**
  ///
  /// **Param:**
  ///
  /// requestData: your request data, id
  ///
  /// **Returns:**
  ///
  /// Return customer
  Future<dynamic> getCustomers({required int id, required RequestData requestData}) async {
    try {
      dynamic res = await _httpClient.get(
        "${Endpoints.customers}/$id",
        data: requestData,
      );
      return res;
    } catch (_) {
      rethrow;
    }
  }

  /// **Post cusomers**
  ///
  /// **Param:**
  ///
  /// requestData: your request data, id
  ///
  /// **Returns:**
  ///
  /// Return cusomers
  Future<dynamic> updateCustomers({required int id, required RequestData requestData}) async {
    try {
      dynamic res = await _httpClient.post(
        "${Endpoints.updateCustomers}/$id",
        data: requestData,
      );
      return res;
    } catch (_) {
      rethrow;
    }
  }
}
