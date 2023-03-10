part of 'report_stats_cubit.dart';

class ReportStatsState extends BaseState {
  final ReportStats? reportStats;
  final BaseState actionState;
  const ReportStatsState({
    this.reportStats,
    this.actionState = const InitState(),
  });

  @override
  List<Object?> get props => [reportStats, actionState];

  ReportStatsState copyWith({
    ReportStats? reportStats,
    BaseState? actionState,
  }) {
    return ReportStatsState(
      reportStats: reportStats ?? this.reportStats,
      actionState: actionState ?? this.actionState,
    );
  }

  factory ReportStatsState.fromJson(Map<String, dynamic> json) => _$ReportStatsStateFromJson(json);

  Map<String, dynamic> toJson() => _$ReportStatsStateToJson(this);
}

ReportStatsState _$ReportStatsStateFromJson(Map<String, dynamic> json) => ReportStatsState(
      reportStats: ReportStats.fromJson(json['report_stats']),
    );

Map<String, dynamic> _$ReportStatsStateToJson(ReportStatsState instance) => <String, dynamic>{
      'report_stats': instance.reportStats?.toJson(),
    };
