// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter_store_manager/types/types.dart';
import 'package:flutter_store_manager/utils/currency_format.dart';

// Repository packages
import 'package:order_repository/order_repository.dart';

// View
import 'order_item_date_time.dart';
import 'order_item_status.dart';

//Themes
import 'package:flutter_store_manager/themes.dart';

class OrderItem extends StatelessWidget with OrderMixin {
  final EdgeInsetsGeometry? padding;
  final double? indentDivider;
  final double? endIndentDivider;
  final OrderData? orderData;
  final GestureTapCallback? onTap;

  const OrderItem({
    Key? key,
    this.orderData,
    this.padding,
    this.indentDivider,
    this.endIndentDivider,
    this.onTap,
  }) : super(key: key);

  String formatPrice(BuildContext context, {String price = '0.0'}) {
    return formatCurrency(
      price: price,
      symbol: getSymbol(orderData?.currency ?? "USD"),
      decimalDigits: 2,
      context: context,
    );
  }

  Widget buildInfoItem(BuildContext context, {required ThemeData theme, bool loading = false}) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    double adminFree = ConvertData.stringToDouble(orderData?.vendorOrderDetails?.itemTotal ?? 0) / 10;
    double grossTotal = ConvertData.stringToDouble(orderData?.vendorOrderDetails?.totalCommission ?? 0) + adminFree;

    List<String> products = orderData?.lineItems?.map((e) => '${e.name!.unescape} x${e.quantity}').toList() ?? [];
    String earning = translate('order:text_earning_price',
        {'price': formatPrice(context, price: orderData?.vendorOrderDetails?.totalCommission ?? '0.0')});
    String grossSale = translate('order:text_gross_sale_price', {
      'price': formatPrice(context, price: '$grossTotal'),
    });

    return buildInfo(
      product: products.join(', '),
      earning: earning,
      grossSale: grossSale,
      theme: theme,
      isLoading: loading,
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    bool loading = orderData?.id == null;

    return OrderItemUi(
      icon: buildIcon(theme: theme, isLoading: loading),
      orderId: buildId(
        text: '#${orderData?.id}',
        theme: theme,
        isLoading: loading,
      ),
      status: OrderItemStatus(orderData: orderData),
      dateTimeUser: OrderItemDateTime(
        orderData: orderData,
      ),
      info: buildInfoItem(context, theme: theme, loading: loading),
      padding: padding,
      indentDivider: indentDivider ?? 44,
      endIndentDivider: endIndentDivider,
      onTap: onTap,
    );
  }
}
