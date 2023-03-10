part of 'chart_seller_cubit.dart';

class ChartSellerState extends BaseState {
  final List<SaleProduct>? data;
  final BaseState actionState;

  const ChartSellerState({
    this.data,
    this.actionState = const InitState(),
  });

  @override
  List<Object?> get props => [data, actionState];

  ChartSellerState copyWith({
    List<SaleProduct>? data,
    BaseState? actionState,
  }) {
    return ChartSellerState(
      data: data ?? this.data,
      actionState: actionState ?? this.actionState,
    );
  }
}
