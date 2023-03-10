import 'request/http_client.dart';
import 'request/dio_client.dart';

abstract class NetworkLocator {
  HttpClient get createHttpClient;
}

class NetworkModule {
  final String baseUrl;

  NetworkModule({required this.baseUrl});

  /// A singleton dio_client provider.
  ///
  /// Calling it multiple times will return the same instance.
  HttpClient providerHttpClient() => DioClient(baseUrl);
}
