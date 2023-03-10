import 'configs.dart';
import 'data/data.dart';

Future getEnquiryBoardListApi({int page = 1, int perPage = 10}) async {
  await Future.delayed(timeDelay);
  if (page < 1) {
    throw getDioError(path: '/enquiryBoard', message: 'Page must > 0');
  }
  if (perPage < 10) {
    throw getDioError(path: '/enquiryBoard', message: 'Per page must >= 0');
  }
  int start = (page - 1) * perPage;
  int end = start + perPage > enquiryBoardList.length ? enquiryBoardList.length : start + perPage;
  if (start > enquiryBoardList.length || end > enquiryBoardList.length) {
    return [];
  }
  return enquiryBoardList.sublist(start, end);
}
