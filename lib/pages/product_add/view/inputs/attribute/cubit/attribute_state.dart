part of 'attribute_cubit.dart';

class AttributeState {
  final List<Option> attributes;
  final BaseState actionState;
  final int page;

  const AttributeState({
    this.attributes = const [],
    this.actionState = const InitState(),
    this.page = 0,
  });

  List<Object?> get props => [
        attributes,
        page,
        actionState,
      ];

  AttributeState copyWith({
    List<Option>? attributes,
    BaseState? actionState,
    String? titleOption,
    int? page,
  }) {
    return AttributeState(
      attributes: attributes ?? this.attributes,
      actionState: actionState ?? this.actionState,
      page: page ?? this.page,
    );
  }

  factory AttributeState.fromJson(Map<String, dynamic> json) => _$AttributeStateFromJson(json);

  Map<String, dynamic> toJson() => _$AttributeStateToJson(this);
}

AttributeState _$AttributeStateFromJson(Map<String, dynamic> json) => AttributeState(
      attributes:
          (json['attributes'] as List<dynamic>?)?.map((e) => Option.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );

Map<String, dynamic> _$AttributeStateToJson(AttributeState instance) => <String, dynamic>{
      'attributes': instance.attributes.map((e) => e.toJson()).toList(),
    };
