import 'package:flutter/material.dart';
import 'package:flutter_store_manager/themes.dart';

class NotificationIconItem extends StatelessWidget with NotificationMixin {
  final String type;
  final bool loading;

  const NotificationIconItem({
    Key? key,
    this.type = '',
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    late IconData icon;

    switch (type) {
      case 'direct':
        icon = Icons.chat;
        break;
      case 'notice':
        icon = Icons.announcement;
        break;
      case 'product_review':
        icon = Icons.rate_review;
        break;
      case 'product_lowstk':
        icon = Icons.shopping_cart;
        break;
      case 'withdraw-request':
        icon = Icons.local_atm;
        break;
      case 'refund-request':
        icon = Icons.currency_exchange;
        break;
      case 'new_product':
        icon = Icons.inventory;
        break;
      case 'new_taxonomy_term':
        icon = Icons.category;
        break;
      case 'order':
        icon = Icons.receipt;
        break;
      case 'enquiry':
        icon = Icons.announcement;
        break;
      case 'support':
        icon = Icons.contact_support;
        break;
      case 'new_customer':
        icon = Icons.person_add;
        break;
      case 'new_follower':
        icon = Icons.person_add;
        break;
      case 'registration':
        icon = Icons.person_add;
        break;
      case 'membership':
        icon = Icons.person_add;
        break;
      case 'vendor_approval':
        icon = Icons.approval;
        break;
      case 'membership-reminder':
        icon = Icons.notifications;
        break;
      case 'membership-cancel':
        icon = Icons.cancel;
        break;
      case 'membership-expired':
        icon = Icons.event_busy;
        break;
      case 'vendor-disable':
        icon = Icons.person_off;
        break;
      case 'vendor-enable':
        icon = Icons.person;
        break;
      case 'pay_for_product':
        icon = Icons.payment;
        break;
      case 'shipment_tracking':
        icon = Icons.content_paste_search;
        break;
      case 'shipment_received':
        icon = Icons.receipt_long;
        break;
      case 'verification':
        icon = Icons.domain_verification;
        break;
      case 'review':
        icon = Icons.rate_review;
        break;
      case 'new_delivery_boy':
        icon = Icons.person_add_alt_1;
        break;
      case 'delivery_boy_assign':
        icon = Icons.assignment;
        break;
      case 'delivery_complete':
        icon = Icons.local_shipping;
        break;
      default:
        icon = Icons.autorenew;
    }
    return buildIcon(icon: icon, theme: theme, isLoading: loading);
  }
}
