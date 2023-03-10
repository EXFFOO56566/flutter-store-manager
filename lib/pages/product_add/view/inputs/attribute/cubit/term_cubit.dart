/// Flutter library
import 'package:appcheap_flutter_core/di/di.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';
import 'package:products_repository/products_repository.dart';

part 'term_state.dart';

class TermCubit extends Cubit<TermState> {
  final ProductsRepository productsRepository;
  final String token;
  final RequestCancel _cancelToken = RequestCancel();
  final int idAttribute;
  final String lang;
  final pageSize = 10;

  TermCubit({
    required this.productsRepository,
    required this.token,
    required this.idAttribute,
    required this.lang,
  }) : super(const TermState(optionTerms: []));

  Future<void> getTermAttribute({String? keyword}) async {
    emit(state.copyWith(
      actionState: const LoadingState(),
    ));
    await _getTermAttribute(page: 1);
  }

  Future<void> refresh() async {
    emit(state.copyWith(
      actionState: const LoadingState(),
    ));
    await _getTermAttribute(page: 1);
  }

  Future<void> loadMore() async {
    emit(state.copyWith(
      actionState: const LoadingState(),
    ));
    await _getTermAttribute(page: state.page + 1);
  }

  Future<dynamic> _getTermAttribute({int page = 1}) async {
    try {
      final res = await productsRepository.getTermAttributes(
        id: idAttribute,
        requestData: RequestData(
          query: {
            'lang': lang,
            'app-builder-decode': true,
            'per_page': pageSize,
            'page': page,
          },
          token: token,
          cancelToken: _cancelToken,
        ),
      );

      List<OptionTerm> data = <OptionTerm>[];
      data = res
          .map((value) => OptionTerm.fromJson({
                'term_id': value['id'] ?? 0,
                'name': value['name'] ?? '',
              }))
          .toList()
          .cast<OptionTerm>();
      var newData = state.optionTerms;
      if (page == 1) {
        newData = data;
      } else {
        newData.addAll(data);
      }
      emit(
        state.copyWith(
          actionState: LoadedState(data: newData.length),
          optionTerms: newData,
          page: page,
        ),
      );
    } on DioError catch (e) {
      if (e.type != DioErrorType.cancel) {
        emit(state.copyWith(actionState: ErrorState(data: e.toString())));
      }
    }
  }

  bool get canLoadMore => state.optionTerms.length >= (state.page * pageSize);

  @override
  Future<void> close() {
    _cancelToken.cancel();
    return super.close();
  }
}
