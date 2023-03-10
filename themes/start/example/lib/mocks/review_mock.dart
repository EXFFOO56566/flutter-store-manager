import 'package:collection/collection.dart';
import 'configs.dart';
import 'data/data.dart';

Future getReviewApi({int page = 1, int perPage = 10}) async {
  await Future.delayed(timeDelay);
  if (page < 1) {
    throw getDioError(path: '/review', message: 'Page must > 0');
  }
  if (perPage < 10) {
    throw getDioError(path: '/review', message: 'Per page must >= 0');
  }
  int start = (page - 1) * perPage;
  int end = start + perPage > reviewList.length ? reviewList.length : start + perPage;
  if (start > reviewList.length || end > reviewList.length) {
    return [];
  }
  return reviewList.sublist(start, end);
}

Future approveReviewApi({required String id}) async {
  await Future.delayed(timeDelay);
  Map<String, dynamic>? data = reviewList.firstWhereOrNull((element) => element['ID'] == id);
  if (data == null) {
    throw getDioError(path: '/approve_review', message: 'Not exist id review');
  }
  return {...data, 'approved': data['approved'] == '1' ? '0' : '1'};
}
