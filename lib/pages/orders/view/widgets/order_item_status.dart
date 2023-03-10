// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter_store_manager/types/types.dart';
import 'dart:math' as math;

// Repository packages
import 'package:order_repository/order_repository.dart';

// View
import 'order_select_status.dart';

//Themes
import 'package:flutter_store_manager/themes.dart';

// Constants
import 'package:flutter_store_manager/constants/color_block.dart';

class OrderItemStatus extends StatelessWidget with OrderMixin {
  final OrderData? orderData;
  final bool? isStatus;

  const OrderItemStatus({
    Key? key,
    this.orderData,
    this.isStatus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;

    bool loading = orderData?.id == null;

    String title = '';
    Color color = ColorBlock.orange;

    switch (orderData?.status) {
      case 'completed':
        title = translate('order:text_completed');
        color = ColorBlock.green;
        break;
      case 'processing':
        title = translate('order:text_processing');
        color = theme.primaryColor;
        break;
      case 'on-hold':
        title = translate('order:text_on_hold');
        color = ColorBlock.redError;
        break;
      case 'cancelled':
        title = translate('order:text_cancelled');
        color = ColorBlock.redError;
        break;
      case 'refunded':
        title = translate('order:text_refunded');
        color = ColorBlock.redError;
        break;
      case 'pending':
        title = translate('order:text_pending');
        color = ColorBlock.redError;
        break;
      default:
        title = orderData?.status ?? '';
        color = Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
        break;
    }
    return isStatus == true
        ? OrderSelectStatus(orderData: orderData, title: title, color: color)
        : buildStatus(text: title, color: color, theme: theme, isLoading: loading);
  }
}
