// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Constants
import 'constants/constants.dart';

// Models
import 'models/models.dart';

class CategoryRepository {
  final HttpClient _httpClient;

  CategoryRepository(this._httpClient);

  /// Get list category.
  ///
  /// Must have value [RequestData] to not throws an [Error] .Returns list data category.
  ///
  Future<List<Category>> getCategory({required RequestData requestData}) async {
    try {
      List<dynamic> res = (await _httpClient.get(
        Endpoints.getCategory,
        data: requestData,
      )) as List;
      List<Category> data = List<Category>.of([]);
      if (res.isNotEmpty) {
        data = res.map((e) => Category.fromJson(e)).toList().cast<Category>();
      }
      return data;
    } catch (_) {
      rethrow;
    }
  }
}
