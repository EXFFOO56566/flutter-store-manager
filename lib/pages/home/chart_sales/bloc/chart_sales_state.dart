part of 'chart_sales_cubit.dart';

class ChartSalesHomeState extends BaseState {
  final OrderChartModel? chartModel;
  final String? currency;
  final String? priceDecimal;
  final BaseState actionState;

  const ChartSalesHomeState({
    this.chartModel,
    this.currency,
    this.priceDecimal,
    this.actionState = const InitState(),
  });

  @override
  List<Object?> get props => [chartModel, actionState, currency, priceDecimal];

  ChartSalesHomeState copyWith({
    OrderChartModel? chartModel,
    BaseState? actionState,
    String? currency,
    String? priceDecimal,
  }) {
    return ChartSalesHomeState(
      chartModel: chartModel ?? this.chartModel,
      actionState: actionState ?? this.actionState,
      currency: currency ?? this.currency,
      priceDecimal: priceDecimal ?? this.priceDecimal,
    );
  }
}
