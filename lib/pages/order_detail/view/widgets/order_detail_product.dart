// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter_store_manager/utils/currency_format.dart' as currency_format;
import '../../../../types/types.dart';

// Repository packages
import 'package:order_repository/order_repository.dart';

// View
import 'package:flutter_store_manager/pages/pages.dart';

//Themes
import 'package:flutter_store_manager/themes.dart';

class OrderDetailProduct extends StatelessWidget {
  final LineItems item;
  final String? currency;
  final bool showDiscount;

  const OrderDetailProduct({
    Key? key,
    required this.item,
    this.currency,
    this.showDiscount = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;
    double subtotal = ConvertData.stringToDouble(item.subtotal ?? '');
    double total = ConvertData.stringToDouble(item.total ?? '');
    double earning = item.commissionValue ?? 0;

    return OrderDetailProductItem(
      image: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: CacheImageView(image: item.imageUrl ?? '', width: 41, height: 41),
      ),
      name: TextButton(
        onPressed: () => Navigator.of(context).pushNamed(ProductEditPage.routeName, arguments: item.productId),
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: const Size(0, 0),
          textStyle: theme.textTheme.bodyText2,
        ),
        child: Text(item.name?.unescape ?? ''),
      ),
      price: Text(
        "${formatPrice(context, getPrice(price: subtotal, quantity: item.quantity ?? 1), currency)} x ${item.quantity}",
        style: theme.textTheme.bodyText2,
      ),
      attribute: item.sku?.isNotEmpty == true
          ? Text(
              translate('order:text_sku_value', {'value': item.sku!}),
              style: theme.textTheme.overline?.copyWith(color: theme.textTheme.caption?.color),
            )
          : null,
      total: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: translate('order:text_total_value'), style: TextStyle(color: theme.textTheme.subtitle1?.color)),
              TextSpan(
                  text: formatPrice(context, subtotal.toString(), currency),
                  style: TextStyle(color: theme.textTheme.caption?.color))
            ], style: theme.textTheme.overline),
          ),
          if (showDiscount) ...[
            const SizedBox(height: 4),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: translate('order:text_discount_value'),
                    style: TextStyle(color: theme.textTheme.subtitle1?.color)),
                TextSpan(
                    text: formatPrice(context, (subtotal - total).toString(), currency),
                    style: TextStyle(color: theme.textTheme.caption?.color))
              ], style: theme.textTheme.overline),
            ),
          ],
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: translate('order:text_earning_value'),
                  style: TextStyle(color: theme.textTheme.subtitle1?.color)),
              TextSpan(
                  text: formatPrice(context, earning.toString(), currency),
                  style: TextStyle(color: theme.textTheme.caption?.color))
            ], style: theme.textTheme.overline),
          ),
        ],
      ),
    );
  }

  String getPrice({required double price, int quantity = 1}) {
    return (price / quantity).toString();
  }

  String formatPrice(BuildContext context, String price, String? currency) {
    return currency_format.formatCurrency(
      price: price,
      symbol: currency_format.getSymbol(currency ?? "USD"),
      decimalDigits: 2,
      context: context,
    );
  }
}
