// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter_store_manager/types/types.dart';
import 'package:flutter_store_manager/utils/currency_format.dart' as currency_format;

// Constants
import 'package:flutter_store_manager/constants/color_block.dart';

//Themes
import 'package:flutter_store_manager/themes.dart';

class OrderChartInfo extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final double? gross;
  final double? earn;
  final double? withdrawal;
  final double? refunds;
  final double? average;
  final double? order;
  final double? items;
  final double? tax;
  final double? ship;
  final String? currency;
  final String? priceDecimal;
  final bool isMonthly;

  const OrderChartInfo({
    Key? key,
    this.padding,
    this.gross,
    this.withdrawal,
    this.earn,
    this.refunds,
    this.average,
    this.order,
    this.items,
    this.tax,
    this.ship,
    this.currency,
    this.priceDecimal,
    this.isMonthly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    int decimalDigits = ConvertData.stringToInt(priceDecimal);

    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        padding: padding ?? EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(9, (index) {
            double padEnd = index < 8 ? 8 : 0;
            late String title;
            late String subtitle;
            late Color color;

            switch (index) {
              case 1:
                title = translate('chart:text_total_earn');
                subtitle = currency_format.formatCurrency(
                  price: earn?.toString() ?? '0.0',
                  symbol: currency_format.getSymbol(currency ?? "USD"),
                  decimalDigits: decimalDigits,
                  context: context,
                );
                color = ColorBlock.listChartColor[1][0];
                break;
              case 2:
                title = translate('chart:text_total_withdrawal');
                subtitle = currency_format.formatCurrency(
                  price: withdrawal?.toString() ?? '0.0',
                  symbol: currency_format.getSymbol(currency ?? "USD"),
                  decimalDigits: decimalDigits,
                  context: context,
                );
                color = ColorBlock.listChartColor[6][0];
                break;
              case 3:
                title = translate('chart:text_total_refunds');
                subtitle = currency_format.formatCurrency(
                  price: refunds?.toString() ?? '0.0',
                  symbol: currency_format.getSymbol(currency ?? "USD"),
                  decimalDigits: decimalDigits,
                  context: context,
                );
                color = ColorBlock.listChartColor[2][0];
                break;
              case 4:
                title = (isMonthly)
                    ? translate('chart:text_average_monthly_sale')
                    : translate('chart:text_average_daily_sale');
                subtitle = currency_format.formatCurrency(
                  price: average?.toString() ?? '0.0',
                  symbol: currency_format.getSymbol(currency ?? "USD"),
                  decimalDigits: decimalDigits,
                  context: context,
                );
                color = Colors.grey.withOpacity(0.3);
                break;
              case 5:
                title = translate('chart:text_order_place');
                subtitle = "${order?.toStringAsFixed(0)}";
                color = ColorBlock.listChartColor[5][0];
                break;
              case 6:
                title = translate('chart:text_items_purchased');
                subtitle = "${items?.toStringAsFixed(0)}";
                color = Colors.orange.withOpacity(0.5);
                break;
              case 7:
                title = translate('chart:text_total_tax');
                subtitle = currency_format.formatCurrency(
                  price: tax?.toString() ?? '0.0',
                  symbol: currency_format.getSymbol(currency ?? "USD"),
                  decimalDigits: decimalDigits,
                  context: context,
                );
                color = ColorBlock.listChartColor[3][0];
                break;
              case 8:
                title = translate('chart:text_charged_for_ship');
                subtitle = currency_format.formatCurrency(
                  price: ship?.toString() ?? '0.0',
                  symbol: currency_format.getSymbol(currency ?? "USD"),
                  decimalDigits: decimalDigits,
                  context: context,
                );
                color = ColorBlock.listChartColor[4][0];
                break;
              default:
                title = translate('chart:text_gross_in_period');
                subtitle = currency_format.formatCurrency(
                  price: gross?.toString() ?? '0.0',
                  symbol: currency_format.getSymbol(currency ?? "USD"),
                  decimalDigits: decimalDigits,
                  context: context,
                );
                color = ColorBlock.listChartColor[0][0];
            }

            return Padding(
              padding: EdgeInsetsDirectional.only(end: padEnd),
              child: OrderChartItemInfo(
                title: title,
                subtitle: subtitle,
                colorLine: color,
              ),
            );
          }),
        ),
      ),
    );
  }
}
