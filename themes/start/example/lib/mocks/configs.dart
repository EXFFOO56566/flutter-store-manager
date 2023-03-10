import 'package:dio/dio.dart';

Duration timeDelay = const Duration(milliseconds: 1500);

DioError getDioError({required String path, required String message}) {
  RequestOptions requestOptions = RequestOptions(path: path);

  return DioError(
    requestOptions: requestOptions,
    response: Response(
      requestOptions: requestOptions,
      data: {'message': message},
    ),
  );
}
