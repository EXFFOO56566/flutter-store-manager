// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Packages & Dependencies or Helper function
import 'package:equatable/equatable.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

//Repository packages
import 'package:reports_repository/reports_repository.dart';

part 'report_stats_state.dart';

class ReportStatsCubit extends Cubit<ReportStatsState> {
  final ReportsRepository reportsRepository;
  final String token;
  final RequestCancel _cancelToken = RequestCancel();
  final void Function(BaseState store)? onChanged;
  ReportStatsCubit({
    required this.reportsRepository,
    required this.token,
    this.onChanged,
    Equatable? value,
  }) : super(value != null ? value as ReportStatsState : ReportStatsState(reportStats: ReportStats()));

  Future<void> getStats() async {
    emit(state.copyWith(
      actionState: const LoadingState(),
    ));
    await _getStats();
  }

  Future<void> _getStats() async {
    try {
      ReportStats stats = await reportsRepository.getReportStats(
        requestData: RequestData(token: token, cancelToken: _cancelToken, query: {'app-builder-decode': true}),
      );
      emit(
        state.copyWith(actionState: LoadedState(data: stats), reportStats: stats),
      );
    } on RequestError catch (e) {
      if (e.type != RequestErrorType.cancel) {
        emit(state.copyWith(actionState: ErrorState(data: e.message)));
      }
    }
  }

  @override
  void onChange(Change<ReportStatsState> change) {
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
