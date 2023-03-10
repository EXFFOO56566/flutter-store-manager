import 'package:appcheap_flutter_core/di/di.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';
import 'package:order_repository/order_repository.dart';

part 'order_note_state.dart';

class OrderNoteCubit extends Cubit<OrderNoteState> {
  final OrderRepository orderRepository;
  final String token;
  final RequestCancel _cancelToken = RequestCancel();
  OrderNoteCubit({
    required this.orderRepository,
    required this.token,
  }) : super(const OrderNoteState());

  void addNoteChanged({String? value}) {
    emit(state.copyWith(addNoteValue: value));
  }

  void selectCustomer({String? value}) {
    emit(state.copyWith(selectedCustomer: value));
  }

  Future<void> getOrderNotes({required int id}) async {
    try {
      List<OrderNote> orderNotes = await orderRepository.getOrderNote(
        id: id,
        requestData: RequestData(
          query: {'app-builder-decode': true},
          token: token,
          cancelToken: _cancelToken,
        ),
      );
      emit(
        state.copyWith(
          orderNotes: orderNotes,
        ),
      );
    } on DioError catch (e) {
      if (e.type != DioErrorType.cancel) {
        emit(state.copyWith(actionState: ErrorState(data: e.toString())));
      }
    }
  }

  Future<void> addOrderNotes({
    required int id,
  }) async {
    emit(state.copyWith(addLoadingState: const LoadingState()));
    try {
      await orderRepository.addOrderNote(
        id: id,
        requestData: RequestData(
          token: token,
          query: {'app-builder-decode': true},
          data: {
            "note": state.addNoteValue,
            "customer_note": state.selectedCustomer == '0' ? true : false,
          },
          cancelToken: _cancelToken,
        ),
      );
      await getOrderNotes(id: id);
      emit(state.copyWith(
        addNoteValue: '',
        addLoadingState: const LoadedState(),
      ));
    } on DioError catch (e) {
      if (e.type != DioErrorType.cancel) {
        emit(state.copyWith(addLoadingState: ErrorState(data: e.toString())));
      }
    }
  }

  @override
  Future<void> close() {
    _cancelToken.cancel();
    return super.close();
  }
}
