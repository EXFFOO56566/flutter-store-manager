// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Constants
import 'constants/constants.dart';

// Models
import 'models/models.dart';

class OrderRepository {
  final HttpClient _httpClient;

  OrderRepository(this._httpClient);

  /// **Get order**
  ///
  /// **Param:**
  ///
  /// requestData: your request data
  ///
  /// **Returns:**
  ///
  /// Return list order
  Future<List<OrderData>> getOrderList({required RequestData requestData}) async {
    try {
      List<dynamic> res = await _httpClient.get(
        Endpoints.getOrders,
        data: requestData,
      );
      List<OrderData> orders = List<OrderData>.of([]);
      if (res.isNotEmpty) {
        orders = res.map((e) => OrderData.fromJson(e)).toList().cast<OrderData>();
      }

      return orders;
    } on RequestError {
      rethrow;
    }
  }

  /// **Get order**
  ///
  /// **Param:**
  ///
  /// requestData: your request data, passing id parameter
  ///
  /// **Returns:**
  ///
  /// Return order detail
  Future<OrderData> getOrderDetail({required int id, RequestData? requestData}) async {
    try {
      dynamic res = await _httpClient.get(
        "${Endpoints.getOrders}/$id",
        data: requestData,
      );

      OrderData orderDetail = OrderData.fromJson(res);

      if (res.isNotEmpty) {
        orderDetail;
      }

      return orderDetail;
    } catch (_) {
      rethrow;
    }
  }

  /// **update order status**
  ///
  /// **Param:**
  ///
  /// requestData: your request data, passing id parameter
  ///
  /// **Returns:**
  ///
  /// Return order status
  Future<OrderData> updateOrderStatus({required int id, RequestData? requestData}) async {
    try {
      dynamic res = await _httpClient.put(
        "${Endpoints.getOrders}/$id",
        data: requestData,
      );

      OrderData orderDetail = OrderData.fromJson(res);

      if (res.isNotEmpty) {
        orderDetail;
      }

      return orderDetail;
    } catch (_) {
      rethrow;
    }
  }

  /// **get order note**
  ///
  /// **Param:**
  ///
  /// requestData: your request data, passing id parameter
  ///
  /// **Returns:**
  ///
  /// Return list order note
  Future<List<OrderNote>> getOrderNote({required int id, RequestData? requestData}) async {
    try {
      List<dynamic> res = await _httpClient.get(
        "${Endpoints.getOrders}/note/$id",
        data: requestData,
      );

      List<OrderNote> orderNotes = List<OrderNote>.of([]);

      if (res.isNotEmpty) {
        orderNotes = res.map((e) => OrderNote.fromJson(e)).toList().cast<OrderNote>();
      }

      return orderNotes;
    } catch (_) {
      rethrow;
    }
  }

  /// **Add order note**
  ///
  /// **Param:**
  ///
  /// requestData: your request data, passing id parameter
  ///
  /// **Returns:**
  ///
  /// Return order note
  Future<dynamic> addOrderNote({required int id, RequestData? requestData}) async {
    try {
      await _httpClient.post(
        "${Endpoints.getOrders}/note/$id",
        data: requestData,
      );
    } catch (_) {
      rethrow;
    }
  }

  /// **Get order chart**
  ///
  /// **Param:**
  ///
  /// requestData: your request data,
  ///
  /// **Returns:**
  ///
  /// Return order chart
  Future<dynamic> getOrderChart({required RequestData requestData}) async {
    try {
      dynamic res = await _httpClient.get(
        Endpoints.getOrderChartByDate,
        data: requestData,
      );
      if (res.isNotEmpty) {
        res;
      }
      return res;
    } catch (_) {
      rethrow;
    }
  }
}
