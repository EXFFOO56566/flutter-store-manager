import 'package:example/blocs/blocs.dart';
import 'package:example/mocks/mocks.dart';
import 'package:example/models/models.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'report_state.dart';

class ReportCubit extends HydratedCubit<ReportState> {
  ReportCubit() : super(ReportState(data: ReportModel.fromJson({})));

  Future<void> getReport() async {
    try {
      emit(state.copyWith(
        actionState: const LoadingState(),
      ));
      await _getReviews();
    } catch (_) {}
  }

  void initData() {
    emit(state.copyWith(data: ReportModel.fromJson({})));
  }

  Future<void> _getReviews() async {
    try {
      final data = await getStatApi();

      ReportModel dataResult = ReportModel.fromJson(data);
      emit(
        state.copyWith(
          actionState: LoadedState(data: dataResult.data),
          data: dataResult,
        ),
      );
    } catch (e) {
      emit(state.copyWith(actionState: ErrorState(data: e.toString())));
      rethrow;
    }
  }

  @override
  ReportState fromJson(Map<String, dynamic> json) {
    return ReportState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(ReportState state) {
    return state.toJson();
  }
}
