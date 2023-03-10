// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Constants
import 'constants/constants.dart';

// Models
import 'models/models.dart';

class NotificationRepository {
  final HttpClient _httpClient;

  NotificationRepository(this._httpClient);

  /// **Get notification**
  ///
  /// **Param:**
  ///
  /// requestData: your request data
  ///
  /// **Returns:**
  ///
  /// Return list notification
  Future<List<NotificationData>> getNotifications({required RequestData requestData}) async {
    try {
      List<dynamic> res = await _httpClient.get(
        Endpoints.getNotification,
        data: requestData,
      );

      List<NotificationData> notifications = List<NotificationData>.of([]);

      if (res.isNotEmpty) {
        notifications = res.map((e) => NotificationData.fromJson(e)).toList().cast<NotificationData>();
      }

      return notifications;
    } catch (_) {
      rethrow;
    }
  }

  /// **Get count notification**
  ///
  /// **Param:**
  ///
  /// requestData: your request data
  ///
  /// **Returns:**
  ///
  /// Return count notification
  Future<CountNotificationData> getCountNotification({required RequestData requestData}) async {
    try {
      dynamic res = await _httpClient.get(
        Endpoints.getCountNotification,
        data: requestData,
      );

      CountNotificationData countNotification = CountNotificationData.fromJson(res);

      return countNotification;
    } catch (_) {
      rethrow;
    }
  }

  /// **Read notification**
  ///
  /// **Param:**
  ///
  /// requestData: your request data
  ///
  /// **Returns:**
  ///
  Future<dynamic> updateReadNotification({required RequestData requestData}) async {
    try {
      await _httpClient.post(
        Endpoints.updateReadNotification,
        data: requestData,
      );
    } catch (_) {
      rethrow;
    }
  }

  /// **Delete notification**
  ///
  /// **Param:**
  ///
  /// requestData: your request data
  ///
  /// **Returns:**
  ///
  Future<dynamic> deleteNotification({required RequestData requestData}) async {
    try {
      await _httpClient.delete(
        Endpoints.deleteNotification,
        data: requestData,
      );
    } catch (_) {
      rethrow;
    }
  }
}
