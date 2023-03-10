part of 'report_cubit.dart';

class ReportState {
  final ReportModel data;
  final BaseState actionState;

  const ReportState({
    required this.data,
    this.actionState = const InitState(),
  });

  List<Object?> get props => [data, false];

  ReportState copyWith({
    ReportModel? data,
    BaseState? actionState,
  }) {
    return ReportState(
      data: data ?? this.data,
      actionState: actionState ?? this.actionState,
    );
  }

  factory ReportState.fromJson(Map<String, dynamic> json) => _$ReportStateFromJson(json);

  Map<String, dynamic> toJson() => _$ReportStateToJson(this);
}

ReportState _$ReportStateFromJson(Map<String, dynamic> json) => ReportState(
      data: ReportModel.fromJson((json['data'] ?? {}) as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReportStateToJson(ReportState instance) => <String, dynamic>{
      'data': instance.data.toJson(),
    };
