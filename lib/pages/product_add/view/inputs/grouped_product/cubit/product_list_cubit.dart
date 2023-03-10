/// Flutter library
import 'package:appcheap_flutter_core/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:flutter_store_manager/utils/utils.dart';
import 'package:products_repository/products_repository.dart';

part 'product_list_state.dart';

class ProductListCubit extends Cubit<ProductListState> {
  final ProductsRepository productsRepository;
  final String token;
  final String vendor;
  final int idProduct;
  final RequestCancel _cancelToken = RequestCancel();

  ProductListCubit({
    required this.productsRepository,
    required this.token,
    required this.vendor,
    required this.idProduct,
  }) : super(const ProductListState(data: []));

  void changeSelected(Option option) {
    List<Option> data = [...state.data];
    int indexVisit = data.indexWhere((element) => element.key == option.key);

    if (indexVisit > -1) {
      data.removeAt(indexVisit);
    } else {
      data.add(option);
    }
    emit(state.copyWith(
      data: data,
    ));
  }

  Future<void> getProductSelected({List<int> include = const []}) async {
    emit(state.copyWith(
      actionState: const LoadingState(),
    ));
    await _getProductSelected(include: include);
  }

  Future<dynamic> _getProductSelected({List<int> include = const []}) async {
    try {
      Map<String, dynamic> queryParameters = {
        'vendor': vendor,
        'per_page': include.length,
        'include': include.join(','),
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

      emit(state.copyWith(
        actionState: LoadedState(data: newProduct.length),
        data: newProduct,
      ));
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
