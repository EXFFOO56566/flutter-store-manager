/// Flutter library
import 'package:appcheap_flutter_core/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:flutter_store_manager/utils/utils.dart';
import 'package:products_repository/products_repository.dart';

part 'product_search_state.dart';

class ProductSearchCubit extends Cubit<ProductSearchState> {
  final ProductsRepository productsRepository;
  final String token;
  final String vendor;
  final RequestCancel _cancelToken = RequestCancel();

  ProductSearchCubit({
    required this.productsRepository,
    required this.token,
    required this.vendor,
  }) : super(const ProductSearchState(data: []));

  void onSearch(String key, List<int> exclude) async {
    emit(state.copyWith(
      data: key.length >= 3 ? state.data : [],
    ));
    if (key.length >= 3) {
      await getProductSearch(key, exclude);
    }
  }

  Future<void> getProductSearch(String keyword, List<int> exclude) async {
    emit(state.copyWith(
      actionState: const LoadingState(),
    ));
    await _getProductSearch(keyword, exclude);
  }

  Future<dynamic> _getProductSearch(String keyword, List<int> exclude) async {
    try {
      Map<String, dynamic> queryParameters = {
        'vendor': vendor,
        'per_page': 20,
        'search': keyword,
        'exclude': exclude.join(','),
        'status': 'publish',
        'app-builder-decode': true,
      };

      List<Product> data = await productsRepository.getProducts(
          requestData:
              RequestData(query: preQueryParameters(queryParameters), token: token, cancelToken: _cancelToken));

      List<Option> newProduct = data
          .map((e) => Option(
                key: '${e.id}',
                name: '${e.name}',
              ))
          .toList();

      emit(
        state.copyWith(
          actionState: LoadedState(data: newProduct.length),
          data: newProduct,
        ),
      );
    } on RequestError catch (e) {
      if (e.type != RequestErrorType.cancel) {
        emit(state.copyWith(actionState: ErrorState(data: e.message)));
      }
    }
  }

  @override
  Future<void> close() {
    _cancelToken.cancel();
    return super.close();
  }
}
