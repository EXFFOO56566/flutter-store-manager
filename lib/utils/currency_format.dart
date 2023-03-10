import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/models/currency/currency.dart' show getCurrencies;
import 'package:flutter_store_manager/settings/cubit/settings_cubit.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:intl/intl.dart';

///
/// Get currency symbol
String getSymbol([String currency = 'USD']) {
  Map currencyInfo = getCurrencies[currency];
  return currencyInfo['symbol'];
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
    locale: context.read<SettingsCubit>().state.locate,
    decimalDigits: decimalDigits ?? 0,
    symbol: symbol ?? "",
  );
  return f.format(ConvertData.stringToDouble(price));
}