part of 'variation_list_cubit.dart';

class VariationListState extends Equatable {
  final List<Map<String, dynamic>> data;
  final bool loading;

  const VariationListState({
    this.loading = false,
    this.data = const [],
  });

  @override
  List<Object> get props => [data];

  VariationListState copyWith({
    List<Map<String, dynamic>>? data,
    bool? loading,
  }) {
    return VariationListState(
      data: data ?? this.data,
      loading: loading ?? this.loading,
    );
  }

  factory VariationListState.fromJson(Map<String, dynamic> json) => _$VariationListStateFromJson(json);

  Map<String, dynamic> toJson() => _$VariationListStateToJson(this);
}

VariationListState _$VariationListStateFromJson(Map<String, dynamic> json) => VariationListState(
      loading: json['loading'] as bool,
      data: json['data'] as List<Map<String, dynamic>>,
    );

Map<String, dynamic> _$VariationListStateToJson(VariationListState instance) => <String, dynamic>{
      'loading': instance.loading,
      'data': instance.data,
    };
