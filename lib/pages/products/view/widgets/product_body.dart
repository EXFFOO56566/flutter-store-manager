// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';
import 'package:flutter_store_manager/common/widgets/base_smart_fresher.dart';
import 'package:flutter_store_manager/types/types.dart';

// Repository packages
import 'package:products_repository/products_repository.dart';

// View
import 'package:flutter_store_manager/pages/pages.dart';
import 'package:flutter_store_manager/pages/products/bloc/product_cubit.dart';
import 'package:flutter_store_manager/pages/products/view/widgets/product_item.dart';

//Themes
import 'package:flutter_store_manager/themes.dart' as ui;

class ProductBody extends StatefulWidget {
  const ProductBody({Key? key}) : super(key: key);

  @override
  ProductBodyState createState() => ProductBodyState();
}

class ProductBodyState extends State<ProductBody> {
  late ProductCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<ProductCubit>();
    cubit.resetState();
    cubit.getProducts();
  }

  void clickFilter(BuildContext context, {required TranslateType translate, required ProductState state}) async {
    final List<ui.Option> filters = [
      ui.Option(key: '', name: translate('product:text_products')),
      ui.Option(key: 'simple', name: translate('product:text_simple_product')),
      ui.Option(key: 'variable', name: translate('product:text_variable')),
      ui.Option(key: 'grouped', name: translate('product:text_group')),
      ui.Option(key: 'external', name: translate('product:text_external')),
    ];
    String? value = await showModalBottomSheet<String?>(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        MediaQueryData mediaQuery = MediaQuery.of(context);
        return Container(
          constraints: BoxConstraints(maxHeight: mediaQuery.size.height * 0.8),
          child: ui.ModalOptionApply(
            options: filters,
            value: state.filter,
            onChanged: (String? text) => Navigator.pop(context, text),
            textButton: translate('common:text_apply'),
          ),
        );
      },
    );
    if (value != null && value != state.filter) {
      cubit.filterProduct(filter: value);
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;
    return ui.ProductListContainer(
      title: translate('product:text_products'),
      button: ui.ProductListButtonAdd(
        onPressed: () => Navigator.of(context).pushNamed(ProductAddPage.routeName, arguments: true).then((value) {
          if (value == true) {
            cubit.getProducts();
          }
        }),
      ),
      filter: BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
        final emptyData = state.actionState is! LoadingState && state.products.isEmpty;
        final emptyFilter = emptyData && state.filter == '';
        return !emptyFilter
            ? IconButton(
                icon: const Icon(CommunityMaterialIcons.tune),
                iconSize: 20,
                onPressed: () => clickFilter(context, translate: translate, state: state),
              )
            : const SizedBox.shrink();
      }),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: ui.InputSearchField(
              hintText: translate('product:text_search'),
              onChanged: (value) {
                String keyword = "";
                keyword = value.trim();
                if (cubit.keyword != keyword) {
                  cubit.resetToken();
                  cubit.getProducts(keyword: keyword);
                }
              },
            ),
          ),
          BlocConsumer<ProductCubit, ProductState>(
            builder: (context, state) {
              final canLoadMore = cubit.canLoadMore;
              final emptyData = state.actionState is! LoadingState && state.products.isEmpty;
              return Expanded(
                child: emptyData
                    ? ui.NotificationEmptyView(
                        icon: CommunityMaterialIcons.cube, title: translate('product:text_empty'))
                    : BaseSmartFresher(
                        onRefresh: _refresh,
                        onLoadMore: canLoadMore ? _loadMore : null,
                        child: _body(state, translate, theme),
                      ),
              );
            },
            listener: (context, state) {
              if (state.deleteState is ErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(translate('common:text_delete_failure')),
                ));
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    cubit.close();
  }

  Widget _body(ProductState state, TranslateType translate, ThemeData theme) {
    List<Product> emptyProducts = List.generate(10, (index) => Product()).toList();
    List<Product> data = (state.products.isEmpty) ? emptyProducts : state.products;

    return ListView.builder(
      key: const Key("products"),
      padding: EdgeInsets.zero,
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        final widgetItem = ProductItem(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            indentDivider: 125,
            endIndentDivider: 25,
            product: item,
            index: index,
            onTap: () {
              Navigator.of(context).pushNamed(ProductEditPage.routeName, arguments: item.id).then((value) {
                if (value == true) {
                  cubit.getProducts();
                }
              });
            });
        if (item.id == null) {
          return widgetItem;
        }
        return Dismissible(
          key: Key(item.id.toString()),
          background: ui.BackgroundDismissible(
            background: theme.colorScheme.error,
            icon: CommunityMaterialIcons.trash_can_outline,
          ),
          direction: DismissDirection.endToStart,
          onDismissed: (_) {
            cubit.deleteInUi(
              index: index,
            );
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(
                  content: Text(translate('common:text_deleted')),
                  action: SnackBarAction(
                    label: translate('common:text_undo'),
                    onPressed: () {
                      cubit.undo();
                    },
                  ),
                ))
                .closed
                .then((value) {
              if (value == SnackBarClosedReason.timeout || value == SnackBarClosedReason.hide) {
                cubit.deleteProduct(productId: item.id, index: index);
              }
            });
          },
          child: widgetItem,
        );
      },
    );
  }

  Future _loadMore() async {
    await cubit.loadMore();
  }

  Future _refresh() async {
    await cubit.refresh();
  }
}
