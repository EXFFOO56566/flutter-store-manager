part of 'order_cubit.dart';

class OrderState extends BaseState {
  final List<OrderData> orders;
  final BaseState actionState;
  final int page;
  final String? keyword;
  final String? filter;
  final bool? btnDone;
  const OrderState({
    this.orders = const [],
    this.actionState = const InitState(),
    this.page = 0,
    this.keyword = '',
    this.filter = '',
    this.btnDone = false,
  });

  @override
  List<Object?> get props => [orders, page, actionState, keyword, filter, btnDone];

  OrderState copyWith({
    List<OrderData>? orders,
    BaseState? actionState,
    int? page,
    String? keyword,
    String? filter,
    bool? btnDone,
  }) {
    return OrderState(
      orders: orders ?? this.orders,
      actionState: actionState ?? this.actionState,
      page: page ?? this.page,
      keyword: keyword ?? this.keyword,
      filter: filter ?? this.filter,
      btnDone: btnDone ?? this.btnDone,
    );
  }
}
