import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:bloc/bloc.dart';
import 'package:chart_analytic_repository/chart_analytic_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';

part 'chart_analytic_state.dart';

class ChartAnalyticCubit extends Cubit<ChartAnalyticState> {
  final ChartAnalyticRepository chartAnalyticRepository;
  final String token;
  final RequestCancel _cancelToken = RequestCancel();
  final void Function(BaseState store)? onChanged;

  ChartAnalyticCubit({
    required this.chartAnalyticRepository,
    required this.token,
    this.onChanged,
    Equatable? value,
  }) : super(value != null ? value as ChartAnalyticState : const ChartAnalyticState(data: []));

  Future<void> getAnalytic() async {
    emit(state.copyWith(
      actionState: const LoadingState(),
    ));
    await _getAnalytic();
  }

  Future<void> _getAnalytic() async {
    try {
      final List<AnalyticData> results = await chartAnalyticRepository.getChartAnalytic(
        requestData: RequestData(
          token: token,
          cancelToken: _cancelToken,
          query: {'app-builder-decode': true},
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
  void onChange(Change<ChartAnalyticState> change) {
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
