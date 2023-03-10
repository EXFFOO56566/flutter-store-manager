// Bloc
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:products_repository/products_repository.dart';
import 'package:equatable/equatable.dart';

// utils
import 'package:flutter_bloc/flutter_bloc.dart';

part 'variation_list_state.dart';

class VariationListCubit extends Cubit<VariationListState> {
  final ProductsRepository productsRepository;
  final int idProduct;
  final String token;
  final RequestCancel _cancelToken = RequestCancel();

  VariationListCubit({
    required this.productsRepository,
    required this.idProduct,
    required this.token,
  }) : super(const VariationListState(data: []));

  void deleteVariation(int id) {
    List<Map<String, dynamic>> data =
        state.data.where((element) => ConvertData.stringToInt(element['id']) != id).toList();
    emit(state.copyWith(
      data: data,
    ));
  }

  void updateVariation(Map<String, dynamic> value) {
    List<Map<String, dynamic>> data = [...state.data];
    int checkVisit = data.indexWhere((element) => element['id'] == value['id']);
    if (checkVisit < 0) {
      data.add(value);
    } else {
      data[checkVisit] = value;
    }
    emit(state.copyWith(
      data: data,
    ));
  }

  Future<void> getVariations(List<int> idsVariation) async {
    emit(state.copyWith(loading: true));

    try {
      List<Map<String, dynamic>> data = await productsRepository.getListVariation(
        idProduct: idProduct,
        requestData: RequestData(
          query: {
            'per_page': idsVariation.length,
            'include': idsVariation.join(','),
            'app-builder-decode': true,
          },
          token: token,
          cancelToken: _cancelToken,
        ),
      );
      emit(state.copyWith(
        loading: false,
        data: data,
      ));
    } on RequestError catch (_) {
      emit(state.copyWith(
        loading: false,
      ));
    }
  }

  @override
  Future<void> close() {
    _cancelToken.cancel();
    return super.close();
  }
}
