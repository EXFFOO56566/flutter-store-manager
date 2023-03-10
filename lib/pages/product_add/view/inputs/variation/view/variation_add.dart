import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/authentication/authentication.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:media_repository/media_repository.dart';
import 'package:products_repository/products_repository.dart';
import 'package:flutter_store_manager/themes.dart';

import '../bloc/variation_bloc.dart';
import 'variation_form.dart';

class VariationAddPage extends StatelessWidget with AppbarMixin {
  final int idProduct;
  final List<AttributeData> attributes;
  final String skuParent;

  const VariationAddPage({
    Key? key,
    required this.idProduct,
    required this.attributes,
    this.skuParent = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseStyleAppBar(title: AppLocalizations.of(context)!.translate('product:text_add_variation')),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        behavior: HitTestBehavior.translucent,
        child: BlocProvider(
          create: (context) {
            return VariationBloc(
              mediaRepository: MediaRepository(context.read<HttpClient>()),
              productsRepository: ProductsRepository(context.read<HttpClient>()),
              token: context.read<AuthenticationBloc>().state.token,
              idProduct: idProduct,
              data: {},
              skuParent: skuParent,
            );
          },
          child: VariationForm(
            attributes: attributes,
            button: const ButtonAdd(),
          ),
        ),
      ),
    );
  }
}
