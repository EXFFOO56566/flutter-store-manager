import 'package:intl/intl.dart';

String formatDate({required String date, String dateFormat = 'MMMM d, y', String locate = 'en_US'}) {
  DateTime dateTime = DateTime.parse(date);
  return DateFormat(dateFormat, 'en_US').format(dateTime);
}

bool compareSpaceDate({required String date, int space = 30}) {
  DateTime dateTimeNow = DateTime.now();
  DateTime dateTime = DateTime.parse(date).add(Duration(days: space));
  return !dateTimeNow.isAfter(dateTime);
}

String? formatPosition({Duration? position}) {
  return RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$').firstMatch(position.toString())?.group(1);
}

String formatChartDate({required String? date}) {
  if (date == null) {
    return "";
  }
  DateTime inputDate = DateFormat("MM d yy").parse(date);
  String outputDate = DateFormat('dd\nMMM').format(inputDate);
  return outputDate;
}

String formatDateToDayOfWeek({required String? date}) {
  if (date == null) {
    return "";
  }
  DateTime inputDate = DateFormat("MM d yy").parse(date);
  String outputDate = DateFormat('d\nEE').format(inputDate);
  return outputDate;
}
