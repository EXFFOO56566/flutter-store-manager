// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Constants
import 'constants/constants.dart';

// Models
import 'models/models.dart';

class ReviewRepository {
  final HttpClient _httpClient;

  ReviewRepository(this._httpClient);

  /// Get list review.
  ///
  /// Must have value [RequestData] to not throws an [Error] .Returns list data review.
  ///
  Future<List<Review>> getReview({required RequestData requestData}) async {
    try {
      List<dynamic> res = (await _httpClient.get(
        Endpoints.getReview,
        data: requestData,
      )) as List;
      List<Review> data = List<Review>.of([]);
      if (res.isNotEmpty) {
        data = res.map((e) => Review.fromJson(e)).toList().cast<Review>();
      }
      return data;
    } catch (_) {
      rethrow;
    }
  }

  /// Approve media.
  ///
  /// Must have values: [id] and [RequestData] to not throws an [Error] .Returns a data review.
  ///
  Future<void> approveReview({required String id, required RequestData requestData}) async {
    try {
      await _httpClient.post(
        '${Endpoints.getReview}/$id',
        data: requestData,
      );
    } catch (_) {
      rethrow;
    }
  }
}
