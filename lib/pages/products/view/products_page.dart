// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter_bloc/flutter_bloc.dart';

// Repository packages
import 'package:products_repository/products_repository.dart';

// Bloc
import 'package:flutter_store_manager/authentication/authentication.dart';
import 'package:flutter_store_manager/stores/global/bloc/global_bloc.dart';
import '../bloc/product_cubit.dart';

// View
import 'widgets/product_body.dart';

class ProductsScreen extends StatelessWidget {
  static const routeName = '/products';

  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: BlocProvider(
        create: (context) {
          return ProductCubit(
            onChanged: (store) => context.read<GlobalBloc>().add(GlobalStoreChanged('products', store)),
            value: context.read<GlobalBloc>().state.stores['products'],
            productsRepository: ProductsRepository(context.read<HttpClient>()),
            vendor: context.read<AuthenticationBloc>().state.user.id,
            token: context.read<AuthenticationBloc>().state.token,
          );
        },
        child: const ProductBody(),
      ),
    );
  }
}
