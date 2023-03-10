import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../../screens.dart';

class ReportStat extends StatelessWidget {
  const ReportStat({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => Navigator.pushNamed(context, ReportScreen.routeName),
          child: Row(
            children: [
              Expanded(child: Text('This Month', style: theme.textTheme.subtitle2)),
              const SizedBox(width: 20),
              Text(
                'All Reports',
                style: theme.textTheme.bodyText2?.copyWith(color: theme.primaryColor),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ViewReport(
                icon: CommunityMaterialIcons.cash_usd,
                title: 'Gross Sales',
                titleNumber: '230.555',
                percent: 10.0,
                symbolNumber: '\$',
                colorIcon: theme.primaryColor,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: ViewReport(
                icon: CommunityMaterialIcons.cash_multiple,
                title: 'Earnings',
                titleNumber: '29.996',
                percent: 9.5,
                symbolNumber: '\$',
                colorIcon: Color(0xFFFF5200),
                colorNumber: Color(0xFFFF5200),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: ViewReport(
                icon: CommunityMaterialIcons.cube,
                title: 'Sold Items',
                titleNumber: '60',
                colorIcon: Color(0xFF2BBD69),
                colorNumber: Color(0xFF2BBD69),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ViewReport(
                icon: CommunityMaterialIcons.receipt,
                title: 'Orders Received',
                titleNumber: '40',
                colorIcon: theme.primaryColorDark,
                colorNumber: theme.primaryColorDark,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
