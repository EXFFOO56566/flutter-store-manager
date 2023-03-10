// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Repository packages
import 'package:order_repository/order_repository.dart';

//Themes
import 'package:flutter_store_manager/themes.dart';

class OrderItemDateTime extends StatelessWidget with OrderMixin {
  final OrderData? orderData;

  const OrderItemDateTime({
    Key? key,
    this.orderData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    bool loading = orderData?.id == null;

    String vendor = '${orderData?.shipping?.firstName ?? ''} ${orderData?.shipping?.lastName ?? ''}'.trim();
    return buildDateTimeUser(
      date: formatDate(date: orderData?.dateCreated ?? DateTime.now().toString(), dateFormat: 'dd/MM/yyyy'),
      time: formatDate(date: orderData?.dateCreated ?? DateTime.now().toString(), dateFormat: 'hh:mm a'),
      vendor: AppLocalizations.of(context)!.translate('order:text_by', {
        'name': vendor.isEmpty ? 'Guest' : vendor,
      }),
      theme: theme,
      isLoading: loading,
    );
  }
}
