// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// View
import 'package:flutter_store_manager/common/widgets/base_smart_fresher.dart';
import 'package:flutter_store_manager/pages/home/view/chart_analytic.dart';
import 'package:flutter_store_manager/pages/home/view/chart_sales.dart';
import 'package:flutter_store_manager/pages/home/view/chart_seller.dart';
import 'package:flutter_store_manager/pages/home/view/report_stat.dart';
import 'package:flutter_store_manager/pages/order_chart/view/order_chart_page.dart';
import 'home_user_view.dart';

import 'package:flutter_store_manager/themes.dart';

// Constants
import 'package:flutter_store_manager/constants/dimension.dart';

class HomeTab extends StatefulWidget with AppbarMixin {
  const HomeTab({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with AppbarMixin {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: theme.canvasColor,
      body: Padding(
        padding: EdgeInsets.only(top: mediaQuery.padding.top + 20),
        child: SizedBox(
          height: getHeight(context),
          child: BaseSmartFresher(
            onRefresh: _refresh,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(25, 0, 25, 32),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HomeUserView(),
                    const SizedBox(height: 37),
                    Column(
                      children: [
                        ReportStat(key: UniqueKey()),
                        const SizedBox(height: 50),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ChartSalesHome(key: UniqueKey()),
                            const SizedBox(height: 8),
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed(OrderChartPage.routeName);
                                },
                                style: TextButton.styleFrom(
                                  textStyle: Theme.of(context).textTheme.bodyText2,
                                  minimumSize: Size.zero,
                                  padding: EdgeInsets.zero,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(AppLocalizations.of(context)!.translate('home:text_see_more')),
                                    const Icon(Icons.chevron_right, size: 22),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 40),
                            ChartSeller(key: UniqueKey()),
                            const SizedBox(height: 30),
                            ChartAnalytic(key: UniqueKey()),
                            const SizedBox(height: 30),
                          ],
                        ),
                        // const SizedBox(height: 150),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _refresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {});
  }
}
