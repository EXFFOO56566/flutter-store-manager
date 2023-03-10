// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Packages & Dependencies or Helper function
import 'package:equatable/equatable.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';
import 'package:flutter_store_manager/utils/query.dart';
import 'package:replay_bloc/replay_bloc.dart';

// Repository packages
import 'package:products_repository/products_repository.dart';

part 'product_state.dart';

class ProductCubit extends ReplayCubit<ProductState> {
  final void Function(BaseState store) onChanged;
  final String vendor;
  final String token;
  final pageSize = 10;
  final ProductsRepository productsRepository;
  RequestCancel _cancelToken = RequestCancel();

  ProductCubit({
    required this.productsRepository,
    required this.vendor,
    required this.token,
    Equatable? value,
    required this.onChanged,
  }) : super(value != null ? value as ProductState : const ProductState(products: []));

  String? get keyword => state.keyword;

  Future<void> getProducts({String? keyword}) async {
    if (keyword != null) {
      emit(state.copyWith(
        actionState: const LoadingState(),
        keyword: keyword,
        products: [],
      ));
      await _getProducts(page: 1);
    } else {
      emit(state.copyWith(
        actionState: const LoadingState(),
      ));
      await _getProducts(page: 1);
    }
  }

  Future<void> deleteProduct({int? productId, int? index}) async {
    await _deleteProducts(productId: productId, index: index);
  }

  Future<void> filterProduct({String? filter}) async {
    emit(state.copyWith(
      actionState: const LoadingState(),
      filter: filter,
      products: [],
    ));
    await _getProducts(page: 1);
  }

  void deleteInUi({int? index}) {
    if (index != null) {
      final products = [...state.products];
      products.removeAt(index);
      emit(
        ProductState(
          actionState: LoadedState(data: products.length),
          products: products,
        ),
      );
    } else {}
  }

  Future<void> refresh() async {
    await _getProducts(page: 1);
  }

  Future<void> loadMore() async {
    await _getProducts(page: state.page + 1);
  }

  void resetState() {
    emit(
      state.copyWith(
        keyword: '',
        filter: '',
      ),
    );
  }

  Future<void> _getProducts({int page = 1}) async {
    try {
      Map<String, dynamic> queryParameters = {
        'vendor': vendor,
        'page': page,
        'per_page': pageSize,
        'search': state.keyword,
        'type': state.filter,
        'app-builder-decode': true,
      };

      List<Product> data = await productsRepository.getProducts(
          requestData:
              RequestData(query: preQueryParameters(queryParameters), token: token, cancelToken: _cancelToken));

      var newProduct = state.products;
      if (page == 1) {
        newProduct = data;
      } else {
        newProduct.addAll(data);
      }
      emit(
        state.copyWith(
          actionState: LoadedState(data: newProduct.length),
          products: newProduct,
          page: page,
        ),
      );
    } on RequestError catch (e) {
      if (e.type != RequestErrorType.cancel) {
        emit(state.copyWith(actionState: ErrorState(data: e.message)));
      }
    }
  }

  Future<void> _deleteProducts({int? productId, int? index}) async {
    if (productId != null) {
      try {
        await productsRepository.deleteProducts(
          productId: productId,
          requestData: RequestData(
            token: token,
            query: {'app-builder-decode': true},
            cancelToken: _cancelToken,
          ),
        );
        emit(state.copyWith(deleteState: const LoadedState()));
      } on RequestError catch (_) {
        undo();
        emit(state.copyWith(deleteState: const ErrorState()));
        rethrow;
      }
    } else {}
  }

  bool get canLoadMore => state.products.length >= (state.page * pageSize);
  @override
  void onChange(Change<ProductState> change) {
    super.onChange(change);
    onChanged(change.nextState);
  }

  @override
  Future<void> close() {
    _cancelToken.cancel();
    return super.close();
  }

  void resetToken() {
    _cancelToken.cancel();
    if (_cancelToken.isCancelled) {
      _cancelToken = RequestCancel();
    }
  }
}
