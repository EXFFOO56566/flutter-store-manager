import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:example/blocs/blocs.dart';
import 'package:intl/intl.dart';

import 'convert_data.dart';

///
/// Get currency symbol
String getSymbol([String currency = 'USD']) {
  return '\$';
}

///
/// Format currency
///
String formatCurrency({
  String? price,
  required BuildContext context,
  int? decimalDigits,
  String? symbol,
}) {
  // Return empty price
  if (price == null || price.isEmpty || price == "") {
    return "";
  }

  NumberFormat f = NumberFormat.currency(
    locale: context.read<SettingCubit>().state.locale,
    decimalDigits: decimalDigits ?? 0,
    symbol: symbol ?? "",
  );
  return f.format(ConvertData.stringToDouble(price));
}
