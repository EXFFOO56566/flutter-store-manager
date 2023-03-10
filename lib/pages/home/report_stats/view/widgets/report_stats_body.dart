// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/constants/color_block.dart';
import 'package:flutter_store_manager/utils/currency_format.dart' as currency_format;

// Repository packages
import 'package:reports_repository/reports_repository.dart';

// Bloc
import 'package:flutter_store_manager/pages/home/report_stats/bloc/report_stats_cubit.dart';

// View
import 'package:flutter_store_manager/pages/pages.dart';
import 'package:flutter_store_manager/themes.dart';

class ReportStatsBody extends StatefulWidget {
  const ReportStatsBody({Key? key}) : super(key: key);

  @override
  ReportStatsBodyState createState() => ReportStatsBodyState();
}

class ReportStatsBodyState extends State<ReportStatsBody> {
  late ReportStatsCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<ReportStatsCubit>();
    cubit.getStats();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportStatsCubit, ReportStatsState>(builder: (context, state) {
      ThemeData theme = Theme.of(context);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => Navigator.pushNamed(context, ReportPage.routeName),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)!.translate('home:text_month'),
                    style: theme.textTheme.subtitle2,
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  AppLocalizations.of(context)!.translate('home:text_all_report'),
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
                  title: AppLocalizations.of(context)!.translate('home:text_gross_sale'),
                  titleNumber: (state.reportStats?.data?.month?.grossSales != null)
                      ? currency_format.formatCurrency(
                          price: state.reportStats!.data!.month!.grossSales!.toString(),
                          decimalDigits: ConvertData.stringToInt(state.reportStats?.priceDecimal),
                          context: context,
                        )
                      : " ",
                  percent: getPercentGross(state.reportStats),
                  symbolNumber: currency_format.getSymbol(state.reportStats?.currency ?? "USD"),
                  colorIcon: theme.primaryColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ViewReport(
                  icon: CommunityMaterialIcons.cash_multiple,
                  title: AppLocalizations.of(context)!.translate('home:text_earning'),
                  titleNumber: (state.reportStats?.data?.month?.totalEarn != null)
                      ? currency_format.formatCurrency(
                          price: state.reportStats!.data!.month!.totalEarn!.toString(),
                          decimalDigits: ConvertData.stringToInt(state.reportStats?.priceDecimal),
                          context: context,
                        )
                      : " ",
                  percent: getPercentEarn(state.reportStats),
                  symbolNumber: currency_format.getSymbol(state.reportStats?.currency ?? "USD"),
                  colorIcon: ColorBlock.orange,
                  colorNumber: ColorBlock.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ViewReport(
                  icon: CommunityMaterialIcons.cube,
                  title: AppLocalizations.of(context)!.translate('home:text_sold_item'),
                  titleNumber: (state.reportStats?.data?.month?.totalItems != null)
                      ? state.reportStats!.data!.month!.totalItems!.toString()
                      : " ",
                  colorIcon: ColorBlock.green,
                  colorNumber: ColorBlock.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ViewReport(
                  icon: CommunityMaterialIcons.receipt,
                  title: AppLocalizations.of(context)!.translate('home:text_order_received'),
                  titleNumber: (state.reportStats?.data?.month?.totalOrders != null)
                      ? state.reportStats!.data!.month!.totalOrders!.toString()
                      : " ",
                  colorIcon: theme.primaryColorDark,
                  colorNumber: theme.primaryColorDark,
                ),
              ),
            ],
          ),
        ],
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    cubit.close();
  }

  double getPercentGross(ReportStats? stats) {
    if (stats != null) {
      if (stats.data?.month?.grossSales != null && stats.data?.lastMonth?.grossSales != null) {
        if (stats.data!.lastMonth!.grossSales != 0) {
          double res = ((stats.data!.month!.grossSales! / stats.data!.lastMonth!.grossSales!) * 100 - 100);
          return double.parse(res.toStringAsFixed(2));
        }
      }
    }
    return 0;
  }

  double getPercentEarn(ReportStats? stats) {
    if (stats != null) {
      if (stats.data?.month?.totalEarn != null && stats.data?.lastMonth?.totalEarn != null) {
        if (stats.data?.lastMonth?.totalEarn != 0) {
          double res = ((stats.data!.month!.totalEarn! / stats.data!.lastMonth!.totalEarn!) * 100.0 - 100.0);
          return double.parse(res.toStringAsFixed(2));
        }
      }
    }
    return 0;
  }
}
