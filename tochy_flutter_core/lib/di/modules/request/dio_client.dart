import 'package:dio/dio.dart';

import 'http_client.dart';
import '../../../utils/debug.dart';

/// Request Cancel Token
class RequestCancel extends CancelToken {}

/// Request Data
class RequestData {
  Map<String, dynamic>? query;

  String? token;

  dynamic data;

  String? responseType;

  String? contentTypeHeader;

  RequestCancel? cancelToken;

  Options? get options {
    Map<String, dynamic>? headers;

    if (token != null) {
      headers = {
        'Authorization': 'Bearer $token',
      };
    }
    if (contentTypeHeader != null) {
      headers?.addAll({
        'content-type': contentTypeHeader,
      });
    }

    if (contentTypeHeader != null && headers == null) {
      headers = {
        'content-type': contentTypeHeader,
      };
    }

    ResponseType type = responseType == 'plain' ? ResponseType.plain : ResponseType.json;
    return Options(headers: headers, responseType: type);
  }

  void Function(int count, int total)? onReceiveProgress;

  RequestData({
    this.query,
    this.data,
    this.responseType,
    this.cancelToken,
    this.onReceiveProgress,
    this.token,
    this.contentTypeHeader,
  });
}

/// Request Error Type
enum RequestErrorType {
  /// It occurs when url is opened timeout.
  connectTimeout,

  /// It occurs when url is sent timeout.
  sendTimeout,

  ///It occurs when receiving timeout.
  receiveTimeout,

  /// When the server response, but with a incorrect status, such as 404, 503...
  response,

  /// When the request is cancelled, dio will throw a error with this type.
  cancel,

  /// Default error type, Some other Error. In this case, you can
  /// use the DioError.error if it is not null.
  other,
}

/// Request Error
class RequestError implements Exception {
  String message;
  RequestErrorType type;

  RequestError({required this.message, this.type = RequestErrorType.other});

  factory RequestError.fromJson(Object e) {
    String message = '';
    RequestErrorType type = RequestErrorType.other;

    if (e is String) {
      message = e;
    }

    if (e is DioError) {
      if (e.message == "Http status error [500]") {
        message = e.message;
      } else {
        message = (e.response != null && e.response?.data != null) ? e.response?.data['message'] : e.message;
      }
    }

    if (e is DioError && e.type == DioErrorType.cancel) {
      type = RequestErrorType.cancel;
    }

    if (e is DioError && e.type == DioErrorType.connectTimeout) {
      type = RequestErrorType.connectTimeout;
    }

    return RequestError(message: message, type: type);
  }
}

/// Dio Http Client
class DioClient implements HttpClient {
  // dio instance
  final Dio _dio;

  DioClient(String baseUrl) : _dio = _createDio(baseUrl);

  @override
  Future<dynamic> get(String uri, {RequestData? data}) async {
    try {
      final Response response = await _dio.get(
        uri,
        queryParameters: data?.query,
        options: data?.options,
        cancelToken: data?.cancelToken,
        onReceiveProgress: data?.onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      throw RequestError.fromJson(e);
    }
  }

  @override
  Future delete(String uri, {RequestData? data}) async {
    try {
      final Response response = await _dio.delete(
        uri,
        queryParameters: data?.query,
        options: data?.options,
        cancelToken: data?.cancelToken,
      );
      return response.data;
    } catch (e) {
      throw RequestError.fromJson(e);
    }
  }

  @override
  Future post(String uri, {RequestData? data}) async {
    try {
      final Response response = await _dio.post(
        uri,
        data: data?.data,
        queryParameters: data?.query,
        options: data?.options,
        cancelToken: data?.cancelToken,
        onSendProgress: data?.onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      throw RequestError.fromJson(e);
    }
  }

  @override
  Future put(String uri, {RequestData? data}) async {
    try {
      final Response response = await _dio.put(
        uri,
        data: data?.data,
        queryParameters: data?.query,
        options: data?.options,
        cancelToken: data?.cancelToken,
        onReceiveProgress: data?.onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      throw RequestError.fromJson(e);
    }
  }
}

// Helper create dio with interceptors
Dio _createDio(String baseUrl) {
  final dio = Dio();

  dio
    ..options.baseUrl = baseUrl
    ..options.headers = {'Content-Type': 'application/json; charset=utf-8'}
    ..interceptors.add(LogInterceptor(
      error: false,
      logPrint: (error) => avoidPrint(error),
      request: false,
      requestBody: false,
      requestHeader: false,
      responseHeader: false,
      responseBody: false,
    ));

  return dio;
}
