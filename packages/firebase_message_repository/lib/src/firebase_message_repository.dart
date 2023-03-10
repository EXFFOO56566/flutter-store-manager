// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Constants
import 'constants/constants.dart';

class FirebaseMessageRepository {
  final HttpClient _httpClient;
  FirebaseMessageRepository(this._httpClient);

  /// **Update User Token**
  ///
  /// **Param:**
  ///
  /// requestData: your request data
  ///
  /// **Returns:**
  ///
  /// Return data as Map()
  Future<Map<String, dynamic>> updateUserToken({required RequestData requestData}) async {
    try {
      final res = (await _httpClient.post(
        Endpoints.updateUserToken,
        data: requestData,
      ));
      return res;
    } catch (_) {
      rethrow;
    }
  }

  /// **Remove User Token**
  ///
  /// **Param:**
  ///
  /// requestData: your request data
  ///
  /// **Returns:**
  ///
  /// Return data as Map()
  Future<Map<String, dynamic>?> removeUserToken({
    required RequestData requestData,
  }) async {
    try {
      final res = (await _httpClient.post(
        Endpoints.removeUserToken,
        data: requestData,
      ));
      return res;
    } catch (_) {
      rethrow;
    }
  }
}
