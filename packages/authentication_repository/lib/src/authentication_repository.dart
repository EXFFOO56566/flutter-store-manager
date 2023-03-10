// Flutter library
import 'dart:async';

// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Constants
import 'constants/endpoints.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<Map<String, dynamic>>();

  final HttpClient _httpClient;
  AuthenticationRepository(this._httpClient);

  Stream<Map<String, dynamic>> get status async* {
    yield* _controller.stream;
  }

  Future<Map<String, dynamic>> logIn({required RequestData requestData}) async {
    try {
      final res = await _httpClient.post(Endpoints.login, data: requestData);
      _controller.add(res);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> register({required RequestData requestData}) async {
    try {
      final res = await _httpClient.post(Endpoints.register, data: requestData);
      _controller.add({...res, 'isNewVendor': true});
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> current({required RequestData requestData}) async {
    try {
      final res = await _httpClient.get(Endpoints.current, data: requestData);
      _controller.add(res);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> digitsLogin({required RequestData requestData}) async {
    try {
      final res = await _httpClient.post(Endpoints.digitsLogin, data: requestData);
      _controller.add(res['data']);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> digitsRegister({required RequestData requestData}) async {
    try {
      final res = await _httpClient.post(Endpoints.digitsRegister, data: requestData);
      _controller.add({...res['data'], 'isNewVendor': true});
      return res;
    } catch (e) {
      rethrow;
    }
  }

  /// Forgot password
  Future<dynamic> forgotPassword({required RequestData requestData}) async {
    try {
      final res = await _httpClient.post(Endpoints.forgotPassword, data: requestData);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  /// **Change password**
  ///
  /// **Param:**
  ///
  /// requestData: your request data
  ///
  /// **Returns:**
  ///
  /// Return dynamic
  Future<dynamic> changePassword({required RequestData requestData}) async {
    try {
      final res = await _httpClient.post(
        Endpoints.changePassword,
        data: requestData,
      );
      return res;
    } catch (_) {
      rethrow;
    }
  }

  /// Digits Send Otp
  Future<Map<String, dynamic>> digitsSendOtp({required RequestData requestData}) async {
    try {
      final res = await _httpClient.post(Endpoints.digitsSendOtp, data: requestData);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  /// Digits resend otp
  Future<Map<String, dynamic>> digitsReSendOtp({required RequestData requestData}) async {
    try {
      final res = await _httpClient.post(Endpoints.digitsReSendOtp, data: requestData);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  /// Register verify otp
  Future<Map<String, dynamic>> digitsVerifyOtp({required RequestData requestData}) async {
    try {
      final res = await _httpClient.post(Endpoints.digitsVerifyOtp, data: requestData);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  /// Send otp to delete account
  Future<Map<String, dynamic>> sendOptDeleteAccount({required RequestData requestData}) async {
    try {
      final res = await _httpClient.post(Endpoints.sendOptDeleteAccount, data: requestData);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  /// Delete account
  Future<Map<String, dynamic>> deleteAccount({required RequestData requestData}) async {
    try {
      final res = await _httpClient.post(Endpoints.deleteAccount, data: requestData);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  void logOut() {
    _controller.add({'token': null});
  }

  void dispose() => _controller.close();
}
