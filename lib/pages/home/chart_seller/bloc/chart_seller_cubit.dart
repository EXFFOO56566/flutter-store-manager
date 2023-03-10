import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';
import 'package:sale_product_repository/sale_product_repository.dart';

part 'chart_seller_state.dart';

class ChartSellerCubit extends Cubit<ChartSellerState> {
  final SaleProductRepository saleProductRepository;
  final String token;
  final RequestCancel _cancelToken = RequestCancel();
  final void Function(BaseState store)? onChanged;

  ChartSellerCubit({
    required this.saleProductRepository,
    required this.token,
    this.onChanged,
    Equatable? value,
  }) : super(value != null ? value as ChartSellerState : const ChartSellerState(data: []));

  Future<void> getSeller() async {
    emit(state.copyWith(
      actionState: const LoadingState(),
    ));
    await _getSeller();
  }

  Future<void> _getSeller() async {
    try {
      final List<SaleProduct> results = await saleProductRepository.getSaleProduct(
        requestData: RequestData(
          query: {'app-builder-decode': true},
          cancelToken: _cancelToken,
          token: token,
        ),
      );
      emit(
        state.copyWith(actionState: LoadedState(data: results), data: results),
      );
    } on RequestError catch (e) {
      if (e.type != RequestErrorType.cancel) {
        emit(state.copyWith(actionState: ErrorState(data: e.message)));
      }
    }
  }

  @override
  void onChange(Change<ChartSellerState> change) {
    super.onChange(change);
    if (onChanged != null) {
      onChanged!(change.nextState);
    }
  }

  @override
  Future<void> close() {
    _cancelToken.cancel();
    return super.close();
  }
}
