// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Constants
import 'constants/constants.dart';

// Models
import 'models/models.dart';

class MediaRepository {
  final HttpClient _httpClient;

  MediaRepository(this._httpClient);

  /// Get list media.
  ///
  /// Must have value [RequestData] to not throws an [Error] .Returns list data media.
  ///
  Future<List<Media>> getMedia({required RequestData requestData}) async {
    try {
      List<dynamic> res = (await _httpClient.get(
        Endpoints.getMedia,
        data: requestData,
      )) as List;
      List<Media> data = List<Media>.of([]);
      if (res.isNotEmpty) {
        data = res.map((e) => Media.fromJson(e)).toList().cast<Media>();
      }
      return data;
    } catch (_) {
      rethrow;
    }
  }

  /// Add a media.
  ///
  /// Must have value [RequestData] with data is a path image to not throws an [Error] .Returns a new media.
  ///
  Future<Media> postMedia({required RequestData requestData}) async {
    try {
      dynamic res = await _httpClient.post(
        Endpoints.getMedia,
        data: requestData,
      );
      return Media.fromJson(res);
    } catch (_) {
      rethrow;
    }
  }

  /// Delete a media.
  ///
  /// Must have values: [id] and [RequestData] to not throws an [Error] .Returns bool.
  ///
  Future<bool> deleteMedia({required int id, required RequestData requestData}) async {
    try {
      await _httpClient.delete(
        '${Endpoints.getMedia}/$id',
        data: requestData,
      );
      return true;
    } catch (_) {
      rethrow;
    }
  }
}
