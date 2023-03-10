import 'dart:async';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<Map<String, dynamic>>();

  final Future<Map<String, dynamic>> Function({required Map<String, dynamic> queryParameters}) _loginApi;
  final Future<Map<String, dynamic>> Function({required Map<String, dynamic> queryParameters}) _registerApi;
  final Future<Map<String, dynamic>> Function({required Map<String, dynamic> dataParameters}) _digitsLoginApi;
  final Future<Map<String, dynamic>> Function({required Map<String, dynamic> dataParameters}) _digitsRegisterApi;

  AuthenticationRepository(
    this._loginApi,
    this._registerApi,
    this._digitsLoginApi,
    this._digitsRegisterApi,
  );

  Stream<Map<String, dynamic>> get status async* {
    yield* _controller.stream;
  }

  Future<Map<String, dynamic>> logIn({required Map<String, dynamic> queryParameters}) async {
    try {
      final res = await _loginApi(queryParameters: queryParameters);
      _controller.add(res);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> register({required Map<String, dynamic> queryParameters}) async {
    Map<String, dynamic> data = Map<String, dynamic>.of(queryParameters);
    try {
      final res = await _registerApi(queryParameters: data);
      _controller.add({...res, 'isNewVendor': true});
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> digitsLogin({required Map<String, dynamic> dataParameters}) async {
    try {
      final res = await _digitsLoginApi(dataParameters: dataParameters);
      _controller.add(res['data']);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> digitsRegister({required Map<String, dynamic> dataParameters}) async {
    try {
      final res = await _digitsRegisterApi(dataParameters: dataParameters);
      _controller.add({...res['data'], 'isNewVendor': true});
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
