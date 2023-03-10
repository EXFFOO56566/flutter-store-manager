import 'configs.dart';
import 'data/data.dart';

Future getNotificationListApi({int page = 1, int perPage = 10}) async {
  await Future.delayed(timeDelay);
  if (page < 1) {
    throw getDioError(path: '/notification', message: 'Page must > 0');
  }
  if (perPage < 10) {
    throw getDioError(path: '/notification', message: 'Per page must >= 0');
  }
  int start = (page - 1) * perPage;
  int end = start + perPage > notificationList.length ? notificationList.length : start + perPage;
  if (start > notificationList.length || end > notificationList.length) {
    return [];
  }
  return notificationList.sublist(start, end);
}
