import 'package:flutter/material.dart';
import 'package:flutter_store_manager/constants/color_block.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

class NotificationStatusItem extends StatelessWidget with NotificationMixin {
  final String type;
  final bool loading;

  const NotificationStatusItem({
    Key? key,
    this.type = '',
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;

    late String text;
    late Color color;

    switch (type) {
      case 'direct':
        text = translate('notification:text_type_direct');
        color = theme.primaryColor;
        break;
      case 'notice':
        text = translate('notification:text_type_notice');
        color = theme.primaryColor;
        break;
      case 'product_review':
        text = translate('notification:text_type_product_review');
        color = theme.primaryColor;
        break;
      case 'product_lowstk':
        text = translate('notification:text_type_product_lowstk');
        color = ColorBlock.redError;
        break;
      case 'withdraw-request':
        text = translate('notification:text_type_withdraw_request');
        color = theme.primaryColor;
        break;
      case 'refund-request':
        text = translate('notification:text_type_refund_request');
        color = ColorBlock.yellow;
        break;
      case 'new_product':
        text = translate('notification:text_type_new_product');
        color = theme.primaryColor;
        break;
      case 'new_taxonomy_term':
        text = translate('notification:text_type_new_taxonomy_term');
        color = theme.primaryColor;
        break;
      case 'order':
        text = translate('notification:text_type_order');
        color = theme.primaryColor;
        break;
      case 'enquiry':
        text = translate('notification:text_type_enquiry');
        color = theme.primaryColor;
        break;
      case 'support':
        text = translate('notification:text_type_support');
        color = theme.primaryColor;
        break;
      case 'new_customer':
        text = translate('notification:text_type_new_customer');
        color = theme.primaryColor;
        break;
      case 'new_follower':
        text = translate('notification:text_type_new_follower');
        color = theme.primaryColor;
        break;
      case 'registration':
        text = translate('notification:text_type_registration');
        color = theme.primaryColor;
        break;
      case 'membership':
        text = translate('notification:text_type_membership');
        color = theme.primaryColor;
        break;
      case 'vendor_approval':
        text = translate('notification:text_type_vendor_approval');
        color = ColorBlock.green;
        break;
      case 'membership-reminder':
        text = translate('notification:text_type_membership_reminder');
        color = ColorBlock.yellow;
        break;
      case 'membership-cancel':
        text = translate('notification:text_type_membership_cancel');
        color = ColorBlock.redError;
        break;
      case 'membership-expired':
        text = translate('notification:text_type_membership_expired');
        color = ColorBlock.redError;
        break;
      case 'vendor-disable':
        text = translate('notification:text_type_vendor_disable');
        color = ColorBlock.redError;
        break;
      case 'vendor-enable':
        text = translate('notification:text_type_vendor_enable');
        color = ColorBlock.green;
        break;
      case 'pay_for_product':
        text = translate('notification:text_type_pay_for_product');
        color = ColorBlock.green;
        break;
      case 'shipment_tracking':
        text = translate('notification:text_type_shipment_tracking');
        color = ColorBlock.green;
        break;
      case 'shipment_received':
        text = translate('notification:text_type_shipment_received');
        color = ColorBlock.green;
        break;
      case 'verification':
        text = translate('notification:text_type_verification');
        color = theme.primaryColor;
        break;
      case 'review':
        text = translate('notification:text_type_review');
        color = theme.primaryColor;
        break;
      case 'new_delivery_boy':
        text = translate('notification:text_type_new_delivery_boy');
        color = theme.primaryColor;
        break;
      case 'delivery_boy_assign':
        text = translate('notification:text_type_delivery_boy_assign');
        color = ColorBlock.green;
        break;
      case 'delivery_complete':
        text = translate('notification:text_type_delivery_complete');
        color = ColorBlock.green;
        break;
      default:
        text = translate('notification:text_type_status_update');
        color = ColorBlock.green;
    }
    return buildStatus(text: text, color: color, theme: theme, isLoading: loading);
  }
}
