// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Constants
import 'constants/constants.dart';

class CountryLocaleRepository {
  final HttpClient _httpClient;

  CountryLocaleRepository(this._httpClient);

  /// Get map country locale.
  ///
  /// Must have value [RequestData] to not throws an [Error] .Returns map data country locale.
  ///
  Future<Map> getCountryLocale({required RequestData requestData}) async {
    try {
      Map res = (await _httpClient.get(
        Endpoints.getCountryLocale,
        data: requestData,
      )) as Map;
      return res;
    } catch (_) {
      rethrow;
    }
  }
}
