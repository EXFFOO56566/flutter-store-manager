// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Constants
import 'constants/constants.dart';

// Models
import 'models/models.dart';

class CountryRepository {
  final HttpClient _httpClient;

  CountryRepository(this._httpClient);

  /// Get list country.
  ///
  /// Must have value [RequestData] to not throws an [Error] .Returns list data country.
  ///
  Future<List<Country>> getCountry({required RequestData requestData}) async {
    try {
      final res = (await _httpClient.get(
        Endpoints.getCountries,
        data: requestData,
      ));
      List<Country> data = <Country>[];
      data = res.map((country) => Country.fromJson(country)).toList().cast<Country>();
      return data;
    } catch (_) {
      rethrow;
    }
  }
}
