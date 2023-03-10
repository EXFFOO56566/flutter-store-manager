// Flutter library
import 'package:flutter/material.dart';

// Themes
import 'package:flutter_store_manager/themes.dart';

// Packages and Dependencies or Helpers functions
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/authentication/bloc/authentication_bloc.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:media_repository/media_repository.dart';
import 'package:products_repository/products_repository.dart';

// Bloc
import '../bloc/product_add_bloc.dart';

// View
import 'product_add_form.dart';
import 'product_appbar_leading.dart';

class ProductAddPage extends StatelessWidget with AppbarMixin, LoadingMixin {
  // Route add product
  static const routeName = '/add-product';

  const ProductAddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Future<dynamic> createDraftProduct = ProductsRepository(context.read<HttpClient>()).addProducts(
      requestData: RequestData(
        query: {
          "app-builder-decode": true,
          'name': 'AUTO-DRAFT',
          'status': 'draft',
        },
        token: context.read<AuthenticationBloc>().state.token,
      ),
    );
    return FutureBuilder(
      future: createDraftProduct,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        String title = AppLocalizations.of(context)!.translate('product:text_add');
        late Widget body;
        AppBar? appbar;

        if (snapshot.hasData) {
          body = ProductProvider(
            product: snapshot.data,
            title: title,
            typeAction: ProductAppBarTypeAction.add,
          );
        } else {
          late List<Widget> children;
          if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ];
          } else {
            children = <Widget>[buildLoading()];
          }
          body = Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          );
          appbar = baseStyleAppBar(title: title);
        }
        return Scaffold(
          appBar: appbar,
          body: body,
        );
      },
    );
  }
}

class ProductEditPage extends StatelessWidget with AppbarMixin, LoadingMixin {
  // Route edit product
  static const routeName = '/edit-product';

  const ProductEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int productId = ModalRoute.of(context)!.settings.arguments as int;

    final Future<dynamic> getProduct = ProductsRepository(context.read<HttpClient>()).getAdvancedProduct(
      productId: productId,
      requestData: RequestData(
        query: {"app-builder-decode": true},
        token: context.read<AuthenticationBloc>().state.token,
      ),
    );
    return FutureBuilder(
      future: getProduct,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        String title = AppLocalizations.of(context)!.translate('product:text_edit');
        late Widget body;
        AppBar? appbar;

        if (snapshot.hasData) {
          body = ProductProvider(
            product: snapshot.data,
            title: title,
            typeAction: ProductAppBarTypeAction.edit,
          );
        } else {
          late List<Widget> children;
          if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ];
          } else {
            children = <Widget>[buildLoading()];
          }
          body = Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          );
          appbar = baseStyleAppBar(title: title);
        }
        return Scaffold(
          appBar: appbar,
          body: body,
        );
      },
    );
  }
}

class ProductProvider extends StatelessWidget with AppbarMixin {
  final String title;
  final Map<String, dynamic> product;
  final ProductAppBarTypeAction typeAction;

  const ProductProvider({
    Key? key,
    required this.title,
    required this.product,
    required this.typeAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      behavior: HitTestBehavior.translucent,
      child: BlocProvider(
        create: (context) {
          return ProductAddBloc(
            productsRepository: ProductsRepository(context.read<HttpClient>()),
            mediaRepository: MediaRepository(context.read<HttpClient>()),
            token: context.read<AuthenticationBloc>().state.token,
            product: product,
          );
        },
        child: CustomScrollView(
          slivers: [
            baseSliverAppBar(
              leadingWidget: ProductAppbarLeading(
                typeAction: typeAction,
              ),
              title: title,
              pinned: true,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
            const SliverPadding(
              padding: EdgeInsets.fromLTRB(25, 8, 25, 25),
              sliver: SliverToBoxAdapter(
                child: ProductAddForm(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
