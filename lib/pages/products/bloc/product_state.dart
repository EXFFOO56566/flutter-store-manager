part of 'product_cubit.dart';

class ProductState extends BaseState {
  final List<Product> products;
  final BaseState actionState;
  final int page;
  final String? keyword;
  final String? filter;
  final BaseState deleteState;
  const ProductState(
      {this.products = const [],
      this.actionState = const InitState(),
      this.deleteState = const InitState(),
      this.page = 0,
      this.keyword = '',
      this.filter = ''});

  @override
  List<Object?> get props => [products, page, actionState, keyword, filter, deleteState];

  ProductState copyWith(
      {List<Product>? products,
      BaseState? actionState,
      int? page,
      String? keyword,
      String? filter,
      BaseState? deleteState}) {
    return ProductState(
        products: products ?? this.products,
        actionState: actionState ?? this.actionState,
        page: page ?? this.page,
        keyword: keyword ?? this.keyword,
        filter: filter ?? this.filter,
        deleteState: deleteState ?? this.deleteState);
  }
}
