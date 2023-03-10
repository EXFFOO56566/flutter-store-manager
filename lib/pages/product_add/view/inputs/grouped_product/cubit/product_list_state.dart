part of 'product_list_cubit.dart';

class ProductListState {
  final List<Option> data;
  final BaseState actionState;

  const ProductListState({
    this.data = const [],
    this.actionState = const InitState(),
  });

  ProductListState copyWith({
    List<Option>? data,
    BaseState? actionState,
  }) {
    return ProductListState(
      data: data ?? this.data,
      actionState: actionState ?? this.actionState,
    );
  }

  factory ProductListState.fromJson(Map<String, dynamic> json) => _$ProductListStateFromJson(json);

  Map<String, dynamic> toJson() => _$ProductListStateToJson(this);
}

ProductListState _$ProductListStateFromJson(Map<String, dynamic> json) => ProductListState(
      data: (json['data'] as List<dynamic>?)?.map((e) => Option.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );

Map<String, dynamic> _$ProductListStateToJson(ProductListState instance) => <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
    };
