// App core
import 'package:appcheap_flutter_core/di/modules/modules.dart';

// Packages & Dependencies or Helper function
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';

// Repository packages
import 'package:order_repository/order_repository.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final void Function(BaseState store) onChanged;

  final pageSize = 10;
  final String token;
  final RequestCancel _cancelToken = RequestCancel();
  final OrderRepository orderRepository;

  OrderCubit({
    required this.token,
    Equatable? value,
    required this.onChanged,
    required this.orderRepository,
  }) : super(value != null ? value as OrderState : const OrderState(orders: []));

  Future<void> getOrders({String? keyword, bool btnDone = false}) async {
    emit(state.copyWith(
      actionState: const LoadingState(),
      keyword: keyword,
      btnDone: btnDone,
    ));
    await _getOrders(page: 1);
  }

  Future<void> filterOrder({String? filter}) async {
    emit(state.copyWith(
      actionState: const LoadingState(),
      filter: filter,
    ));
    await _getOrders(page: 1);
  }

  Future<void> refresh() async {
    await _getOrders(page: 1);
  }

  Future<void> loadMore() async {
    emit(state.copyWith(actionState: const LoadedState()));
    await _getOrders(page: state.page + 1);
  }

  void resetState() {
    emit(state.copyWith(
      keyword: '',
      filter: '',
    ));
  }

  Future<void> _getOrders({int page = 1}) async {
    if (state.btnDone == true) {
      emit(state.copyWith(orders: []));
    }
    try {
      List<OrderData> data = await orderRepository.getOrderList(
        requestData: RequestData(
          query: {
            'page': page,
            'per_page': pageSize,
            'search': state.keyword,
            'post_status': (state.filter == '') ? 'pending' : state.filter,
            'app-builder-decode': true
          },
          token: token,
          cancelToken: _cancelToken,
        ),
      );
      var newOrder = state.orders;
      if (page == 1) {
        newOrder = data;
      } else {
        newOrder.addAll(data);
      }
      emit(
        state.copyWith(
          actionState: LoadedState(data: newOrder.length),
          btnDone: false,
          orders: newOrder,
          page: page,
        ),
      );
    } on RequestError catch (e) {
      if (e.type != RequestErrorType.cancel) {
        emit(state.copyWith(actionState: ErrorState(data: e.message)));
      }
    }
  }

  bool get canLoadMore => state.orders.length >= (state.page * pageSize);

  @override
  void onChange(Change<OrderState> change) {
    super.onChange(change);
    onChanged(change.nextState);
  }

  @override
  Future<void> close() {
    _cancelToken.cancel();
    return super.close();
  }
}
