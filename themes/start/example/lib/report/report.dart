import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

List<String> _items = [
  'Last 7 Days',
  'This Month',
  'Last Month',
];

class ReportScreen extends StatelessWidget with AppbarMixin {
  static const routeName = '/report';

  const ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: baseStyleAppBar(title: 'All Reports'),
      backgroundColor: theme.canvasColor,
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(25, 8, 25, 25),
        itemBuilder: (_, int index) {
          return ReportViewInfo(
            title: _items[index],
            children: [
              ViewReport(
                icon: CommunityMaterialIcons.cash_usd,
                title: 'Gross Sales',
                titleNumber: '230.555',
                percent: 10.0,
                symbolNumber: '\$',
                colorIcon: theme.primaryColor,
              ),
              const ViewReport(
                icon: CommunityMaterialIcons.cash_multiple,
                title: 'Earnings',
                titleNumber: '29.996',
                percent: 9.5,
                symbolNumber: '\$',
                colorIcon: Color(0xFFFF5200),
                colorNumber: Color(0xFFFF5200),
              ),
            ],
          );
        },
        separatorBuilder: (_, int index) {
          return const SizedBox(height: 42);
        },
        itemCount: _items.length,
      ),
    );
  }
}
