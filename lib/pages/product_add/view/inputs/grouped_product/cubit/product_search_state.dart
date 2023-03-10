part of 'product_search_cubit.dart';

class ProductSearchState {
  final List<Option> data;
  final BaseState actionState;

  const ProductSearchState({
    this.data = const [],
    this.actionState = const InitState(),
  });

  ProductSearchState copyWith({
    List<Option>? data,
    BaseState? actionState,
  }) {
    return ProductSearchState(
      data: data ?? this.data,
      actionState: actionState ?? this.actionState,
    );
  }

  factory ProductSearchState.fromJson(Map<String, dynamic> json) => _$ProductSearchStateFromJson(json);

  Map<String, dynamic> toJson() => _$ProductSearchStateToJson(this);
}

ProductSearchState _$ProductSearchStateFromJson(Map<String, dynamic> json) => ProductSearchState(
      data: (json['data'] as List<dynamic>?)?.map((e) => Option.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );

Map<String, dynamic> _$ProductSearchStateToJson(ProductSearchState instance) => <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
    };
