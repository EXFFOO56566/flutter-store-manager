// Packages & Dependencies or Helper function
import 'package:dio/dio.dart';

/// The Places API Helper.
///
class GooglePlaceApiHelper {
  final DioCli dioClient;

  static const _unEncodedPathPlaceAutocomplete = 'maps/api/place/autocomplete/json';
  static const _unEncodedPathPlaceDetailAutocomplete = 'maps/api/place/details/json';

  GooglePlaceApiHelper({required this.dioClient});

  /// Place Autocomplete
  ///
  Future<dynamic> getPlaceAutocomplete({
    required Map<String, dynamic> queryParameters,
    CancelToken? cancelToken,
  }) async {
    try {
      Map<String, dynamic> data = await dioClient.get(
        _unEncodedPathPlaceAutocomplete,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
      return data;
    } catch (e) {
      rethrow;
    }
  }

  /// Get place place from id
  ///
  Future<dynamic> getPlaceDetailFromId({
    required Map<String, dynamic> queryParameters,
    CancelToken? cancelToken,
  }) async {
    try {
      Map<String, dynamic> result = await dioClient.get(
        _unEncodedPathPlaceDetailAutocomplete,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );

      return result;
    } catch (e) {
      rethrow;
    }
  }
}

class DioCli {
  // dio instance
  final Dio _dio;

  // injecting dio instance
  DioCli(this._dio);

  // Get: --------------------------------------------------------------------------------------------------------------
  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on DioError {
      rethrow;
    }
  }

  // Post: -------------------------------------------------------------------------------------------------------------
  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on DioError {
      rethrow;
    }
  }

  // Delete: -------------------------------------------------------------------------------------------------------------
  Future<dynamic> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } on DioError {
      rethrow;
    }
  }

  // Put: -------------------------------------------------------------------------------------------------------------
  Future<dynamic> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on DioError {
      rethrow;
    }
  }
}
