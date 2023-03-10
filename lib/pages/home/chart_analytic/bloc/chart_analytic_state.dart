part of 'chart_analytic_cubit.dart';

class ChartAnalyticState extends BaseState {
  final List<AnalyticData>? data;
  final BaseState actionState;

  const ChartAnalyticState({
    this.data,
    this.actionState = const InitState(),
  });

  @override
  List<Object?> get props => [data, actionState];

  ChartAnalyticState copyWith({
    List<AnalyticData>? data,
    BaseState? actionState,
  }) {
    return ChartAnalyticState(
      data: data ?? this.data,
      actionState: actionState ?? this.actionState,
    );
  }
}
