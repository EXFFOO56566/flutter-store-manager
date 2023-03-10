part of 'order_chart_cubit.dart';

class OrderChartState extends BaseState {
  final OrderChartModel? chartModel;
  final LegendData? legendData;
  final String? priceDecimal;
  final String? currency;
  final BaseState actionState;
  final FilterChartOption filterChartOption;
  const OrderChartState({
    this.chartModel,
    this.legendData,
    this.priceDecimal,
    this.currency,
    this.actionState = const InitState(),
    this.filterChartOption = FilterChartOption.sevenDays,
  });

  @override
  List<Object?> get props => [chartModel, actionState, legendData];

  OrderChartState copyWith({
    OrderChartModel? chartModel,
    LegendData? legendData,
    String? priceDecimal,
    String? currency,
    BaseState? actionState,
    FilterChartOption? filterChartOption,
  }) {
    return OrderChartState(
      chartModel: chartModel ?? this.chartModel,
      legendData: legendData ?? this.legendData,
      currency: currency ?? this.currency,
      priceDecimal: priceDecimal ?? this.priceDecimal,
      actionState: actionState ?? this.actionState,
      filterChartOption: filterChartOption ?? this.filterChartOption,
    );
  }
}
