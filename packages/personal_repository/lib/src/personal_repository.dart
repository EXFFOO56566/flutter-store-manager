// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Constants
import 'constants/constants.dart';

class PersonalRepository {
  final HttpClient _httpClient;
  PersonalRepository(this._httpClient);

  /// **Update Personal**
  ///
  /// **Param:**
  ///
  /// requestData: your request data
  ///
  /// **Returns:**
  ///
  /// Return a personal
  Future<dynamic> updatePersonal({required RequestData requestData}) async {
    try {
      final res = await _httpClient.post(
        Endpoints.personal,
        data: requestData,
      );
      return res;
    } catch (_) {
      rethrow;
    }
  }

  /// **Get vendor profile**
  ///
  /// **Param:**
  ///
  /// requestData: your request data
  ///
  /// **Returns:**
  ///
  /// Return a vendor profile
  Future<dynamic> getVendorProfile({RequestData? requestData}) async {
    try {
      final res = await _httpClient.get(
        Endpoints.personal,
        data: requestData,
      );
      return res;
    } catch (_) {
      rethrow;
    }
  }
}
