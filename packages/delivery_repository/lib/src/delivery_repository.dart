// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Constants
import 'constants/constants.dart';

// Models
import 'models/models.dart';

class DeliveryRepository {
  final HttpClient _httpClient;

  DeliveryRepository(this._httpClient);

  /// Get list deliveries.
  ///
  /// Must have value [RequestData] to not throws an [Error] .Returns list data delivery.
  ///
  Future<dynamic> getDeliveries({required RequestData requestData}) async {
    try {
      List<dynamic> res = (await _httpClient.get(
        Endpoints.getDelivery,
        data: requestData,
      )) as List;

      List<Delivery> data = [];
      if (res.isNotEmpty) {
        data = res.map((e) => Delivery.fromJson(e)).toList().cast<Delivery>();
      }
      return data;
    } catch (_) {
      rethrow;
    }
  }

  /// Get delivery stat.
  ///
  /// Must have value [RequestData] to not throws an [Error] .Returns a data delivery stat.
  ///
  Future<DeliveryStat> getDeliveryStat({required RequestData requestData}) async {
    try {
      dynamic res = await _httpClient.get(
        Endpoints.getDeliveryStat,
        data: requestData,
      );
      return DeliveryStat.fromJson(res);
    } catch (_) {
      rethrow;
    }
  }

  /// Mark order delivery
  ///
  /// Must have value [RequestData] to not throws an [Error] .Returns data delivery.
  ///
  Future<dynamic> markDelivery({required RequestData requestData}) async {
    try {
      dynamic res = await _httpClient.post(
        Endpoints.postMarkDelivery,
        data: requestData,
      );
      return Delivery.fromJson(res);
    } catch (_) {
      rethrow;
    }
  }
}
