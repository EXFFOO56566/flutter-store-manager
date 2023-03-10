// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Packages & Dependencies or Helper function
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';

// Repository packages
import 'package:sales_by_date_repository/sales_by_date_repository.dart';

part 'chart_sales_state.dart';

class ChartSalesHomeCubit extends Cubit<ChartSalesHomeState> {
  final SalesByDateRepository salesByDateRepository;
  final String token;
  final RequestCancel _cancelToken = RequestCancel();
  final void Function(BaseState store)? onChanged;
  ChartSalesHomeCubit({
    required this.salesByDateRepository,
    required this.token,
    this.onChanged,
    Equatable? value,
  }) : super(value != null ? value as ChartSalesHomeState : ChartSalesHomeState(chartModel: OrderChartModel()));

  Future<void> getChart() async {
    emit(state.copyWith(
      actionState: const LoadingState(),
    ));
    await _getChart();
  }

  Future<void> _getChart() async {
    try {
      Map<String, dynamic> param = {"range": "7day", 'app-builder-decode': true};
      final data = await salesByDateRepository.getChartByDate(
        requestData: RequestData(
          token: token,
          query: param,
          cancelToken: _cancelToken,
        ),
      );
      OrderChartModel chart = data['chart_model'];
      String? currency = data['currency'];
      String? priceDecimal = data['price_decimal'];
      emit(
        state.copyWith(
          actionState: LoadedState(data: chart),
          chartModel: chart,
          currency: currency,
          priceDecimal: priceDecimal,
        ),
      );
    } on RequestError catch (e) {
      if (e.type != RequestErrorType.cancel) {
        emit(state.copyWith(actionState: ErrorState(data: e.message)));
      }
    }
  }

  @override
  void onChange(Change<ChartSalesHomeState> change) {
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
