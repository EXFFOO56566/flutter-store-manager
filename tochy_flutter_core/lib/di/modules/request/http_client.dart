import 'dio_client.dart';

abstract class HttpClient {
  Future<dynamic> get(String uri, {RequestData? data});

  Future<dynamic> post(String uri, {RequestData? data});

  Future<dynamic> put(String uri, {RequestData? data});

  Future<dynamic> delete(String uri, {RequestData? data});
}
