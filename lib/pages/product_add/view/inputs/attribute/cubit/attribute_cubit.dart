/// Flutter library
import 'package:appcheap_flutter_core/di/di.dart';
import 'package:dio/dio.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:products_repository/products_repository.dart';

part 'attribute_state.dart';

class AttributeCubit extends HydratedCubit<AttributeState> {
  final ProductsRepository productsRepository;
  final String token;
  final RequestCancel _cancelToken = RequestCancel();
  final pageSize = 10;

  AttributeCubit({
    required this.productsRepository,
    required this.token,
  }) : super(const AttributeState(attributes: []));

  Future<void> getAttributes({String? keyword}) async {
    emit(state.copyWith(
      actionState: const LoadingState(),
    ));
    await _getAttributes(page: 1);
  }

  Future<void> refresh() async {
    emit(state.copyWith(
      actionState: const LoadingState(),
    ));
    await _getAttributes(page: 1);
  }

  Future<void> loadMore() async {
    emit(state.copyWith(
      actionState: const LoadingState(),
    ));
    await _getAttributes(page: state.page + 1);
  }

  Future<dynamic> _getAttributes({int page = 1}) async {
    try {
      final res = await productsRepository.getAttributes(
        requestData: RequestData(
          query: {
            'app-builder-decode': true,
            'per_page': pageSize,
            'page': page,
          },
          token: token,
          cancelToken: _cancelToken,
        ),
      );

      List<Option> data = <Option>[];
      data = res
          .map((value) => Option(
                key: '${value['id'] ?? ''}',
                name: value['name'] ?? '',
              ))
          .toList()
          .cast<Option>();
      var newData = state.attributes;
      if (page == 1) {
        newData = data;
      } else {
        newData.addAll(data);
      }
      emit(
        state.copyWith(
          actionState: LoadedState(data: newData.length),
          attributes: newData,
          page: page,
        ),
      );
    } on DioError catch (e) {
      if (e.type != DioErrorType.cancel) {
        emit(state.copyWith(actionState: ErrorState(data: e.toString())));
      }
    }
  }

  bool get canLoadMore => state.attributes.length >= (state.page * pageSize);

  @override
  Future<void> close() {
    _cancelToken.cancel();
    return super.close();
  }

  @override
  AttributeState? fromJson(Map<String, dynamic> json) {
    return AttributeState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AttributeState state) {
    return state.toJson();
  }
}
