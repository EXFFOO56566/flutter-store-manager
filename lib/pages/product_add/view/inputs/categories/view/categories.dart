import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:category_repository/category_repository.dart';
import 'package:flutter/material.dart';

/// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../bloc/product_add_bloc.dart';
import '../cubit/categories_cubit.dart';
import 'categories_form.dart';

class ProductCategories extends StatelessWidget {
  const ProductCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoriesCubit>(
      create: (_) => CategoriesCubit(
        categoryRepository: CategoryRepository(context.read<HttpClient>()),
      ),
      child: BlocBuilder<ProductAddBloc, ProductAddState>(
        buildWhen: (previous, current) => previous.categories != current.categories,
        builder: (context, state) {
          return CategoriesForm(
            selected: state.categories.value,
            onChanged: (List<Category> categories) => context.read<ProductAddBloc>().add(CategoriesChanged(categories)),
          );
        },
      ),
    );
  }
}
