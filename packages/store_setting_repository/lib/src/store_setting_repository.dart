// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Models
import 'package:store_setting_repository/src/models/models.dart';

// Constants
import 'constants/constants.dart';

class StoreSettingRepository {
  final HttpClient _httpClient;

  StoreSettingRepository(this._httpClient);

  /// **Get store setting**
  ///
  /// **Param:**
  ///
  /// requestData: your request data
  ///
  /// **Returns:**
  ///
  /// return data as StoreModel
  Future<StoreModel> getStoreSetting({required RequestData requestData}) async {
    try {
      var res = await _httpClient.get(
        Endpoints.getSettings,
        data: requestData,
      );
      if (res is Map<String, dynamic>) {
        return StoreModel.fromJson(res);
      }
      return StoreModel();
    } catch (_) {
      rethrow;
    }
  }

  /// **Update store setting**
  ///
  /// **Param:**
  ///
  /// requestData: your request data
  ///
  /// **Returns:**
  ///
  Future<void> updateStoreSetting({required RequestData requestData}) async {
    try {
      await _httpClient.post(
        Endpoints.getSettings,
        data: requestData,
      );
    } catch (_) {
      rethrow;
    }
  }

  /// **Post Single Image**
  ///
  /// **Param:**
  ///
  /// requestData: your request data
  ///
  /// **Returns:**
  ///
  /// return data
  Future<dynamic> postImage({
    required RequestData requestData,
  }) async {
    try {
      var res = await _httpClient.post(
        Endpoints.media,
        data: requestData,
      );
      return res;
    } catch (_) {
      rethrow;
    }
  }
}
