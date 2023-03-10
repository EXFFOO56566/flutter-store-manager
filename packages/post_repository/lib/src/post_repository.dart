import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

import 'constants/constants.dart';
import 'models/models.dart';

class PostRepository {
  final HttpClient _httpClient;

  PostRepository(this._httpClient);

  Future<List<Post>> getPost() async {
    try {
      List<dynamic> res = await _httpClient.get(Endpoints.getPosts);

      List<Post> posts = List<Post>.of([]);

      if (res.isNotEmpty) {
        posts = res.map((e) => Post(e['id'], '')).toList().cast<Post>();
      }

      return posts;
    } catch (_) {
      rethrow;
    }
  }
}
