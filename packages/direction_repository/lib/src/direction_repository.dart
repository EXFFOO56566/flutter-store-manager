// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Constants
import 'constants/constants.dart';

class DirectionRepository {
  final HttpClient _httpClient;

  DirectionRepository(this._httpClient);

  /// Get directions
  ///
  /// Must have value [RequestData] to not throws an [Error] .Returns data direction.
  ///
  Future<dynamic> getDirections({required RequestData requestData}) async {
    try {
      dynamic res = await _httpClient.get(
        Endpoints.getDirection,
        data: requestData,
      );
      return res;
    } catch (_) {
      rethrow;
    }
  }
}
