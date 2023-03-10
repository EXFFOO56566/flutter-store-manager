import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:example/models/models.dart';
import 'package:example/utils/currency_format.dart' as currency_format;
import 'package:ui/ui.dart';

class ReportTimeView extends StatelessWidget {
  final String title;
  final StatModel data;
  final int priceDecimal;
  final String currency;

  const ReportTimeView({
    Key? key,
    required this.title,
    required this.data,
    this.priceDecimal = 2,
    this.currency = 'USD',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ReportViewInfo(
      title: title,
      children: [
        ViewReport(
          icon: CommunityMaterialIcons.cash_usd,
          title: 'Gross Sales',
          titleNumber: currency_format.formatCurrency(
            price: '${data.grossSales}',
            decimalDigits: priceDecimal,
            context: context,
          ),
          percent: 10.0,
          symbolNumber: currency_format.getSymbol(currency),
          colorIcon: theme.primaryColor,
        ),
        ViewReport(
          icon: CommunityMaterialIcons.cash_multiple,
          title: 'Earnings',
          titleNumber: currency_format.formatCurrency(
            price: '${data.totalEarn}',
            decimalDigits: priceDecimal,
            context: context,
          ),
          percent: 9.5,
          symbolNumber: currency_format.getSymbol(currency),
          colorIcon: const Color(0xFFFF5200),
          colorNumber: const Color(0xFFFF5200),
        ),
        ViewReport(
          icon: CommunityMaterialIcons.cube,
          title: 'Sold Items',
          titleNumber: '${data.totalItems}',
          colorIcon: const Color(0xFF2BBD69),
          colorNumber: const Color(0xFF2BBD69),
        ),
        ViewReport(
          icon: CommunityMaterialIcons.receipt,
          title: 'Orders Received',
          titleNumber: '${data.totalOrders}',
          colorIcon: theme.primaryColorDark,
          colorNumber: theme.primaryColorDark,
        )
      ],
    );
  }
}
