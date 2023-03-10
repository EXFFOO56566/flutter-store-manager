import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/authentication/authentication.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:products_repository/products_repository.dart';

import '../cubit/product_search_cubit.dart';
import 'product_search_item.dart';

class ProductListModal extends StatelessWidget {
  final List<int> excludeIds;
  final ValueChanged<Option> onClickProduct;

  const ProductListModal({
    Key? key,
    this.excludeIds = const [],
    required this.onClickProduct,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductSearchCubit>(
      create: (_) => ProductSearchCubit(
        productsRepository: ProductsRepository(context.read<HttpClient>()),
        vendor: context.read<AuthenticationBloc>().state.user.id,
        token: context.read<AuthenticationBloc>().state.token,
      ),
      child: _ProductListModal(
        onClickProduct: onClickProduct,
        excludeIds: excludeIds,
      ),
    );
  }
}

class _ProductListModal extends StatefulWidget {
  final List<int> excludeIds;
  final ValueChanged<Option> onClickProduct;

  const _ProductListModal({
    Key? key,
    this.excludeIds = const [],
    required this.onClickProduct,
  }) : super(key: key);

  @override
  _ProductListModalState createState() => _ProductListModalState();
}

class _ProductListModalState extends State<_ProductListModal> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocBuilder<ProductSearchCubit, ProductSearchState>(
      buildWhen: (previous, current) => previous.data != current.data || previous.actionState != current.actionState,
      builder: (_, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 32, 25, 5),
              child: InputSearchField(
                onChanged: (String value) => context.read<ProductSearchCubit>().onSearch(value, widget.excludeIds),
                hintText: 'Search product minimum input character 3',
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(25, 19, 25, 25),
                child:
                    state.actionState is! LoadingState && state.data.isEmpty ? Container() : _buildList(state, theme),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildList(ProductSearchState state, ThemeData theme) {
    List<Option> emptyProducts = List.generate(10, (index) => const Option(key: '0', name: 'Loading')).toList();
    List<Option> data = state.actionState is LoadingState ? emptyProducts : state.data;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(data.length, (index) {
        Option item = data[index];
        return ProductSearchItem(
          item: item,
          onTap: () {
            widget.onClickProduct(item);
          },
        );
      }),
    );
  }
}
