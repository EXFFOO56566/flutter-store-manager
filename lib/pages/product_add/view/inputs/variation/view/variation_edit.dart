import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/authentication/authentication.dart';

import 'package:media_repository/media_repository.dart';
import 'package:products_repository/products_repository.dart';
import 'package:flutter_store_manager/themes.dart';

import '../bloc/variation_bloc.dart';
import 'variation_form.dart';

class VariationEditPage extends StatelessWidget with AppbarMixin, LoadingMixin {
  final int idProduct;
  final Map<String, dynamic> data;
  final List<AttributeData> attributes;
  final String skuParent;

  const VariationEditPage({
    Key? key,
    required this.idProduct,
    required this.data,
    required this.attributes,
    this.skuParent = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int id = ConvertData.stringToInt(data['id']);
    return Scaffold(
      appBar: baseStyleAppBar(title: '#$id'),
      body: _VariationProvider(
        data: data,
        attributes: attributes,
        idProduct: idProduct,
        skuParent: skuParent,
      ),
    );
  }
}

class _VariationProvider extends StatelessWidget {
  final Map<String, dynamic> data;
  final List<AttributeData> attributes;
  final int idProduct;
  final String skuParent;

  const _VariationProvider({
    Key? key,
    required this.data,
    required this.attributes,
    required this.idProduct,
    this.skuParent = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      behavior: HitTestBehavior.translucent,
      child: BlocProvider(
        create: (context) {
          return VariationBloc(
            productsRepository: ProductsRepository(context.read<HttpClient>()),
            mediaRepository: MediaRepository(context.read<HttpClient>()),
            token: context.read<AuthenticationBloc>().state.token,
            idProduct: idProduct,
            data: data,
            skuParent: skuParent,
          );
        },
        child: VariationForm(
          attributes: attributes,
          button: const ButtonUpdate(),
        ),
      ),
    );
  }
}
