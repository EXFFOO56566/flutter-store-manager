// Bloc
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:category_repository/category_repository.dart';
import 'package:equatable/equatable.dart';

// utils
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'categories_state.dart';

class CategoriesCubit extends HydratedCubit<CategoriesState> {
  final CategoryRepository categoryRepository;

  CategoriesCubit({
    required this.categoryRepository,
  }) : super(const CategoriesState());

  List<Map<String, dynamic>> selectCategories = [];

  Future<void> getCategories() async {
    emit(state.copyWith(loading: true));

    try {
      List<Category> data = await categoryRepository.getCategory(requestData: RequestData());
      emit(state.copyWith(
        loading: false,
        categories: data,
      ));
    } on RequestError catch (_) {
      emit(state.copyWith(
        loading: false,
      ));
      rethrow;
    }
  }

  @override
  CategoriesState? fromJson(Map<String, dynamic> json) {
    return CategoriesState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(CategoriesState state) {
    return state.toJson();
  }
}
