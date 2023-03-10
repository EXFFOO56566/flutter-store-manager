// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/common/widgets/base_smart_fresher.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'package:flutter_store_manager/utils/currency_format.dart' as currency_format;

// Repository packages
import 'package:reports_repository/reports_repository.dart';

// Bloc
import 'package:flutter_store_manager/pages/home/report_stats/bloc/report_stats_cubit.dart';

// View
import 'package:flutter_store_manager/themes.dart';

// Constants
import 'package:flutter_store_manager/constants/color_block.dart';

class ReportPageBody extends StatefulWidget {
  const ReportPageBody({Key? key}) : super(key: key);

  @override
  ReportPageBodyState createState() => ReportPageBodyState();
}

class ReportPageBodyState extends State<ReportPageBody> {
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
      return BaseSmartFresher(
        onRefresh: () => cubit.getStats(),
        child: _body(context, state.reportStats),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _body(BuildContext context, ReportStats? stats) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;
    int decimalDigits = ConvertData.stringToInt(stats?.priceDecimal);
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(25, 8, 25, 25),
      child: Column(
        children: [
          ReportViewInfo(
            title: translate('home:text_last_week'),
            children: [
              ViewReport(
                icon: CommunityMaterialIcons.cash_usd,
                title: translate('home:text_gross_sale'),
                titleNumber: (stats?.data?.week?.grossSales != null)
                    ? currency_format.formatCurrency(
                        price: stats!.data!.week!.grossSales!.toString(),
                        decimalDigits: decimalDigits,
                        context: context,
                      )
                    : " ",
                percent: null,
                symbolNumber: currency_format.getSymbol(stats?.currency ?? "USD"),
                colorIcon: theme.primaryColor,
              ),
              ViewReport(
                icon: CommunityMaterialIcons.cash_multiple,
                title: translate('home:text_earning'),
                titleNumber: (stats?.data?.week?.totalEarn != null)
                    ? currency_format.formatCurrency(
                        price: stats!.data!.week!.totalEarn!.toString(),
                        decimalDigits: decimalDigits,
                        context: context,
                      )
                    : " ",
                percent: null,
                symbolNumber: currency_format.getSymbol(stats?.currency ?? "USD"),
                colorIcon: ColorBlock.orange,
                colorNumber: ColorBlock.orange,
              ),
              ViewReport(
                icon: CommunityMaterialIcons.cube,
                title: translate('home:text_sold_item'),
                titleNumber: (stats?.data?.week?.totalItems != null) ? stats!.data!.week!.totalItems!.toString() : " ",
                colorIcon: ColorBlock.green,
                colorNumber: ColorBlock.green,
              ),
              ViewReport(
                icon: CommunityMaterialIcons.receipt,
                title: translate('home:text_order_received'),
                titleNumber:
                    (stats?.data?.week?.totalOrders != null) ? stats!.data!.week!.totalOrders!.toString() : " ",
                colorIcon: theme.primaryColorDark,
                colorNumber: theme.primaryColorDark,
              ),
            ],
          ),
          const SizedBox(height: 42),
          ReportViewInfo(
            title: translate('home:text_month'),
            children: [
              ViewReport(
                icon: CommunityMaterialIcons.cash_usd,
                title: translate('home:text_gross_sale'),
                titleNumber: (stats?.data?.month?.grossSales != null)
                    ? currency_format.formatCurrency(
                        price: stats!.data!.month!.grossSales!.toString(),
                        decimalDigits: decimalDigits,
                        context: context,
                      )
                    : " ",
                percent: getPercentGross(stats),
                symbolNumber: currency_format.getSymbol(stats?.currency ?? "USD"),
                colorIcon: theme.primaryColor,
              ),
              ViewReport(
                icon: CommunityMaterialIcons.cash_multiple,
                title: translate('home:text_earning'),
                titleNumber: (stats?.data?.month?.totalEarn != null)
                    ? currency_format.formatCurrency(
                        price: stats!.data!.month!.totalEarn!.toString(),
                        decimalDigits: decimalDigits,
                        context: context,
                      )
                    : " ",
                percent: getPercentEarn(stats),
                symbolNumber: currency_format.getSymbol(stats?.currency ?? "USD"),
                colorIcon: ColorBlock.orange,
                colorNumber: ColorBlock.orange,
              ),
              ViewReport(
                icon: CommunityMaterialIcons.cube,
                title: translate('home:text_sold_item'),
                titleNumber:
                    (stats?.data?.month?.totalItems != null) ? stats!.data!.month!.totalItems!.toString() : " ",
                colorIcon: ColorBlock.green,
                colorNumber: ColorBlock.green,
              ),
              ViewReport(
                icon: CommunityMaterialIcons.receipt,
                title: translate('home:text_order_received'),
                titleNumber:
                    (stats?.data?.month?.totalOrders != null) ? stats!.data!.month!.totalOrders!.toString() : " ",
                colorIcon: theme.primaryColorDark,
                colorNumber: theme.primaryColorDark,
              ),
            ],
          ),
          const SizedBox(height: 42),
          ReportViewInfo(
            title: translate('home:text_last_month'),
            children: [
              ViewReport(
                icon: CommunityMaterialIcons.cash_usd,
                title: translate('home:text_gross_sale'),
                titleNumber: (stats?.data?.lastMonth?.grossSales != null)
                    ? currency_format.formatCurrency(
                        price: stats!.data!.lastMonth!.grossSales!.toString(),
                        decimalDigits: decimalDigits,
                        context: context,
                      )
                    : " ",
                percent: null,
                symbolNumber: currency_format.getSymbol(stats?.currency ?? "USD"),
                colorIcon: theme.primaryColor,
              ),
              ViewReport(
                icon: CommunityMaterialIcons.cash_multiple,
                title: translate('home:text_earning'),
                titleNumber: (stats?.data?.lastMonth?.totalEarn != null)
                    ? currency_format.formatCurrency(
                        price: stats!.data!.lastMonth!.totalEarn!.toString(),
                        decimalDigits: decimalDigits,
                        context: context,
                      )
                    : " ",
                percent: null,
                symbolNumber: currency_format.getSymbol(stats?.currency ?? "USD"),
                colorIcon: ColorBlock.orange,
                colorNumber: ColorBlock.orange,
              ),
              ViewReport(
                icon: CommunityMaterialIcons.cube,
                title: translate('home:text_sold_item'),
                titleNumber:
                    (stats?.data?.lastMonth?.totalItems != null) ? stats!.data!.lastMonth!.totalItems!.toString() : " ",
                colorIcon: ColorBlock.green,
                colorNumber: ColorBlock.green,
              ),
              ViewReport(
                icon: CommunityMaterialIcons.receipt,
                title: translate('home:text_order_received'),
                titleNumber: (stats?.data?.lastMonth?.totalOrders != null)
                    ? stats!.data!.lastMonth!.totalOrders!.toString()
                    : " ",
                colorIcon: theme.primaryColorDark,
                colorNumber: theme.primaryColorDark,
              ),
            ],
          ),
          const SizedBox(height: 42),
          ReportViewInfo(
            title: translate('home:text_year'),
            children: [
              ViewReport(
                icon: CommunityMaterialIcons.cash_usd,
                title: translate('home:text_gross_sale'),
                titleNumber: (stats?.data?.year?.grossSales != null)
                    ? currency_format.formatCurrency(
                        price: stats!.data!.year!.grossSales!.toString(),
                        decimalDigits: decimalDigits,
                        context: context,
                      )
                    : " ",
                percent: null,
                symbolNumber: currency_format.getSymbol(stats?.currency ?? "USD"),
                colorIcon: theme.primaryColor,
              ),
              ViewReport(
                icon: CommunityMaterialIcons.cash_multiple,
                title: translate('home:text_earning'),
                titleNumber: (stats?.data?.year?.totalEarn != null)
                    ? currency_format.formatCurrency(
                        price: stats!.data!.year!.totalEarn!.toString(),
                        decimalDigits: decimalDigits,
                        context: context,
                      )
                    : " ",
                percent: null,
                symbolNumber: currency_format.getSymbol(stats?.currency ?? "USD"),
                colorIcon: ColorBlock.orange,
                colorNumber: ColorBlock.orange,
              ),
              ViewReport(
                icon: CommunityMaterialIcons.cube,
                title: translate('home:text_sold_item'),
                titleNumber: (stats?.data?.year?.totalItems != null) ? stats!.data!.year!.totalItems!.toString() : " ",
                colorIcon: ColorBlock.green,
                colorNumber: ColorBlock.green,
              ),
              ViewReport(
                icon: CommunityMaterialIcons.receipt,
                title: translate('home:text_order_received'),
                titleNumber:
                    (stats?.data?.year?.totalOrders != null) ? stats!.data!.year!.totalOrders!.toString() : " ",
                colorIcon: theme.primaryColorDark,
                colorNumber: theme.primaryColorDark,
              ),
            ],
          ),
        ],
      ),
    );
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
