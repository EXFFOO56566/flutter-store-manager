// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/common/widgets/date_picker.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'package:intl/intl.dart';

// Bloc
import '../../bloc/order_chart_cubit.dart';

class OrderChartTab extends StatefulWidget {
  final List<FilterChartOption> optionTabs;

  const OrderChartTab({
    Key? key,
    required this.optionTabs,
  }) : super(key: key);

  @override
  OrderChartTabState createState() => OrderChartTabState();
}

class OrderChartTabState extends State<OrderChartTab> {
  DateTimeRange? dateRange;
  late TabController _tabController;

  ///this variable use to handle case: click tab custom then
  /// click close pickDateRange dialog
  int previousTab = 3;

  Future<bool> pickDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now().add(const Duration(hours: 24 * 3)),
    );
    final newDateRange = await showDateRangePickers(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDateRange: dateRange ?? initialDateRange,
    );

    setState(() {
      dateRange = newDateRange;
    });
    if (newDateRange?.start != null && newDateRange?.end != null) {
      if (mounted) {
        context.read<OrderChartCubit>().getChart(
              option: FilterChartOption.custom,
              start: newDateRange?.start,
              end: newDateRange?.end,
            );
      }
      return true;
    } else {
      return false;
    }
  }

  Widget buildItemTab(FilterChartOption option, TranslateType translate, ThemeData theme) {
    late String text;

    switch (option) {
      case FilterChartOption.lastMonth:
        text = translate('chart:text_last_month');
        break;
      case FilterChartOption.thisMonth:
        text = translate('chart:text_this_month');
        break;
      case FilterChartOption.sevenDays:
        text = translate('chart:text_last_seven_day');
        break;
      case FilterChartOption.custom:
        text = translate('chart:text_custom');
        break;
      default:
        text = translate('chart:text_year');
    }
    if (option == FilterChartOption.custom) {
      final start = dateRange?.start != null ? DateFormat('yyyy/MM/dd').format(dateRange!.start) : null;
      final end = dateRange?.end != null ? DateFormat('yyyy/MM/dd').format(dateRange!.end) : null;

      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text),
          const SizedBox(width: 8),
          const Icon(CommunityMaterialIcons.tune, size: 16),
          if (start != null || end != null) ...[
            const SizedBox(width: 8),
            Text(
              '($start to $end)',
              style: theme.textTheme.overline?.copyWith(color: theme.textTheme.caption?.color),
            ),
          ],
        ],
      );
    }
    return Text(text);
  }

  @override
  Widget build(BuildContext context) {
    _tabController = DefaultTabController.of(context)!;
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;

    return BlocBuilder<OrderChartCubit, OrderChartState>(
      builder: (context, state) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            const Positioned(bottom: -1, left: 0, right: 0, child: Divider(height: 1, thickness: 1)),
            Align(
              alignment: AlignmentDirectional.bottomStart,
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                tabs: List.generate(
                    widget.optionTabs.length, (index) => buildItemTab(widget.optionTabs[index], translate, theme)),
                labelColor: theme.textTheme.subtitle1?.color,
                unselectedLabelColor: theme.textTheme.caption?.color,
                indicatorColor: theme.primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 25),
                indicatorPadding: EdgeInsets.zero,
                labelStyle: theme.textTheme.caption,
                labelPadding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                onTap: (visit) async {
                  final optionSelect = widget.optionTabs[visit];
                  if (optionSelect != FilterChartOption.custom && optionSelect != state.filterChartOption) {
                    previousTab = visit;
                    context.read<OrderChartCubit>().getChart(option: optionSelect);
                    setState(() {
                      dateRange = null;
                    });
                  } else {
                    if (optionSelect == FilterChartOption.custom) {
                      await pickDateRange(context).then((value) {
                        if (!value) {
                          if (previousTab != 4) {
                            previousTab = _tabController.previousIndex;
                            _tabController.animateTo(_tabController.previousIndex);
                          } else {
                            previousTab = visit;
                          }
                        } else {
                          previousTab = visit;
                        }
                      });
                    }
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
