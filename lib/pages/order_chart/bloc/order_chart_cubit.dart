// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Packages & Dependencies or Helper function
import 'package:bloc/bloc.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';
import 'package:intl/intl.dart';

// Repository packages
import 'package:sales_by_date_repository/sales_by_date_repository.dart';

part 'order_chart_state.dart';

enum FilterChartOption { year, lastMonth, thisMonth, sevenDays, custom }

class OrderChartCubit extends Cubit<OrderChartState> {
  final SalesByDateRepository salesByDateRepository;
  final String token;
  final RequestCancel _cancelToken = RequestCancel();
  OrderChartCubit({required this.salesByDateRepository, required this.token})
      : super(OrderChartState(chartModel: OrderChartModel(), legendData: LegendData()));

  Future<void> getChart({FilterChartOption? option, DateTime? start, DateTime? end}) async {
    if (option != null) {
      emit(state.copyWith(
        filterChartOption: option,
        chartModel: OrderChartModel(),
        legendData: LegendData(),
        actionState: const LoadingState(),
      ));
    } else {
      emit(state.copyWith(
        actionState: const LoadingState(),
      ));
    }
    await _getChart(start: start, end: end);
  }

  Future<void> _getChart({DateTime? start, DateTime? end}) async {
    var param = <String, dynamic>{
      'app-builder-decode': true,
    };
    switch (state.filterChartOption) {
      case FilterChartOption.year:
        param.addAll({"range": "year"});
        break;
      case FilterChartOption.lastMonth:
        param.addAll({"range": "last_month"});
        break;
      case FilterChartOption.sevenDays:
        param.addAll({"range": "7day"});
        break;
      case FilterChartOption.custom:
        param.addAll({"range": "custom", "start_date": _formatDateToParam(start), "end_date": _formatDateToParam(end)});
        break;
      default:
        param.addAll({"range": "month"});
    }
    try {
      final Map<String, dynamic> data = await salesByDateRepository.getChartByDate(
        requestData: RequestData(token: token, cancelToken: _cancelToken, query: param),
      );
      OrderChartModel chart = data['chart_model'];
      LegendData legendData = data['legend_data'];
      String? currency = data['currency'];
      String? priceDecimal = data['price_decimal'];
      emit(
        state.copyWith(
            actionState: LoadedState(data: chart),
            chartModel: chart,
            currency: currency,
            priceDecimal: priceDecimal,
            legendData: legendData),
      );
    } on RequestError catch (e) {
      if (e.type != RequestErrorType.cancel) {
        emit(state.copyWith(actionState: ErrorState(data: e.toString())));
      }
    }
  }

  _formatDateToParam(DateTime? date) {
    if (date == null) {
      return "";
    }
    String outputDate = DateFormat('yyyy-MM-dd').format(date);
    return outputDate;
  }

  @override
  Future<void> close() {
    _cancelToken.cancel();
    return super.close();
  }
}
