// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Constants
import 'constants/constants.dart';

class CaptchaRepository {
  final HttpClient _httpClient;

  CaptchaRepository(this._httpClient);

  /// Get Captcha.
  Future<dynamic> getCaptcha({RequestData? requestData}) async {
    try {
      Map? res = await _httpClient.get(
        Endpoints.getCaptcha,
        data: requestData,
      );

      return res;
    } catch (_) {
      rethrow;
    }
  }

  /// Validate captcha
  ///
  /// Must have value [RequestData] to not throws an [Error].
  ///
  Future<dynamic> validateCaptcha({required RequestData requestData}) async {
    try {
      await _httpClient.post(
        Endpoints.validateCaptcha,
        data: requestData,
      );
    } catch (_) {
      rethrow;
    }
  }
}
