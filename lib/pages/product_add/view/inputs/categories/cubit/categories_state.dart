part of 'categories_cubit.dart';

class CategoriesState extends Equatable {
  final List<Category> categories;
  final bool loading;

  const CategoriesState({
    this.loading = true,
    this.categories = const [],
  });

  @override
  List<Object> get props => [categories];

  CategoriesState copyWith({
    List<Category>? categories,
    bool? loading,
  }) {
    return CategoriesState(
      categories: categories ?? this.categories,
      loading: loading ?? this.loading,
    );
  }

  factory CategoriesState.fromJson(Map<String, dynamic> json) => _$CategoriesStateFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesStateToJson(this);
}

CategoriesState _$CategoriesStateFromJson(Map<String, dynamic> json) => CategoriesState(
      loading: json['loading'] as bool,
      categories: json['categories'].map((category) => Category.fromJson(category)).toList().cast<Category>(),
    );

Map<String, dynamic> _$CategoriesStateToJson(CategoriesState instance) => <String, dynamic>{
      'loading': instance.loading,
      'categories': instance.categories.map((category) => category.toJson()).toList()
    };
