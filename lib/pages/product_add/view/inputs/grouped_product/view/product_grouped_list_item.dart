import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/authentication/authentication.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';

import 'package:flutter_store_manager/themes.dart';
import 'package:products_repository/products_repository.dart';

import '../cubit/product_list_cubit.dart';
import 'product_list_modal.dart';

class ProductGroupedListItem extends StatelessWidget {
  final int id;
  final List<int> productIds;
  final ValueChanged<int> onChanged;

  const ProductGroupedListItem({
    Key? key,
    required this.id,
    this.productIds = const [],
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductListCubit>(
      create: (_) => ProductListCubit(
        productsRepository: ProductsRepository(context.read<HttpClient>()),
        vendor: context.read<AuthenticationBloc>().state.user.id,
        token: context.read<AuthenticationBloc>().state.token,
        idProduct: id,
      ),
      child: _ProductGroupedListItem(productIds: [...productIds], onChanged: onChanged),
    );
  }
}

class _ProductGroupedListItem extends StatefulWidget {
  final List<int> productIds;
  final ValueChanged<int> onChanged;

  const _ProductGroupedListItem({
    Key? key,
    this.productIds = const [],
    required this.onChanged,
  }) : super(key: key);

  @override
  _ProductGroupedListItemState createState() => _ProductGroupedListItemState();
}

class _ProductGroupedListItemState extends State<_ProductGroupedListItem> with LoadingMixin {
  late ProductListCubit cubit;

  @override
  void initState() {
    cubit = context.read<ProductListCubit>();
    if (widget.productIds.isNotEmpty) {
      cubit.getProductSelected(include: widget.productIds);
    }
    super.initState();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  void onModalProduct(BuildContext context) async {
    Option? data = await showModalBottomSheet<Option?>(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        MediaQueryData mediaQuery = MediaQuery.of(context);
        double height = mediaQuery.size.height - mediaQuery.viewInsets.top - mediaQuery.viewInsets.bottom;

        return Container(
          constraints: BoxConstraints(maxHeight: height - mediaQuery.size.height * 0.2),
          child: ProductListModal(
            excludeIds: widget.productIds,
            onClickProduct: (Option product) {
              Navigator.pop(context, product);
            },
          ),
        );
      },
    );
    if (data != null) {
      widget.onChanged(ConvertData.stringToInt(data.key));
      cubit.changeSelected(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductListCubit, ProductListState>(
      buildWhen: (previous, current) => previous.data != current.data || previous.actionState != current.actionState,
      builder: (_, state) {
        if (state.actionState is LoadingState) {
          return buildLoading();
        }
        return InputGroupOption(
          value: state.data,
          onChanged: (List<Option> data) {
            Option? selectOption =
                state.data.firstWhereOrNull((element) => data.indexWhere((e) => e.key == element.key) < 0);
            if (selectOption != null) {
              widget.onChanged(ConvertData.stringToInt(selectOption.key));
              cubit.changeSelected(selectOption);
            }
          },
          minHeight: 50,
          trailing: InkResponse(
            onTap: () => onModalProduct(context),
            child: const Icon(CommunityMaterialIcons.chevron_right),
          ),
        );
      },
    );
  }
}
