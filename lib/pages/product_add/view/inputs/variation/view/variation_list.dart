import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/authentication/authentication.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'package:products_repository/products_repository.dart';

import '../bloc/variation_list_cubit.dart';
import 'variation_detail_page.dart';
import 'variation_item.dart';

class VariationList extends StatelessWidget {
  final int idProduct;
  final List<int> idsVariation;
  final ValueChanged<int> onChanged;
  final List<AttributeData> attributes;
  final String skuParent;

  const VariationList({
    Key? key,
    required this.idProduct,
    required this.idsVariation,
    required this.onChanged,
    this.attributes = const [],
    this.skuParent = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return VariationListCubit(
          productsRepository: ProductsRepository(context.read<HttpClient>()),
          token: context.read<AuthenticationBloc>().state.token,
          idProduct: idProduct,
        );
      },
      child: _VariationList(
        idsVariation: idsVariation,
        onChanged: onChanged,
        attributes: attributes,
        skuParent: skuParent,
      ),
    );
  }
}

class _VariationList extends StatefulWidget {
  final List<int> idsVariation;
  final ValueChanged<int> onChanged;
  final List<AttributeData> attributes;
  final String skuParent;

  const _VariationList({
    Key? key,
    required this.idsVariation,
    required this.onChanged,
    this.attributes = const [],
    this.skuParent = '',
  }) : super(key: key);

  @override
  _VariationListState createState() => _VariationListState();
}

class _VariationListState extends State<_VariationList> {
  late VariationListCubit _cubit;

  @override
  void initState() {
    _cubit = context.read<VariationListCubit>();
    if (widget.idsVariation.isNotEmpty) {
      _cubit.getVariations(widget.idsVariation);
    }

    super.initState();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  void onVariationDetail(
    BuildContext context, {
    Map<String, dynamic>? data,
    required int idProduct,
  }) async {
    Map<String, dynamic>? value = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return VariationDetailPage(
            idProduct: idProduct,
            data: data,
            attributes: widget.attributes,
            skuParent: widget.skuParent,
          );
        },
        fullscreenDialog: true,
      ),
    );
    if (value != null) {
      int id = ConvertData.stringToInt(value['id']);
      _cubit.updateVariation(value);
      widget.onChanged(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;

    return BlocBuilder<VariationListCubit, VariationListState>(
      builder: (_, state) {
        List emptyVariations = List.generate(widget.idsVariation.length, (index) => null).toList();
        List data = state.loading ? emptyVariations : state.data;
        return Column(
          children: [
            ...List.generate(
              data.length,
              (index) {
                dynamic item = data[index];
                return VariationItem(
                  idProduct: _cubit.idProduct,
                  data: item,
                  onDelete: (int id) {
                    _cubit.deleteVariation(id);
                    widget.onChanged(id);
                  },
                  onEdit: (data) => onVariationDetail(context, idProduct: _cubit.idProduct, data: data),
                );
              },
            ),
            if (data.isNotEmpty) const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => onVariationDetail(context, idProduct: _cubit.idProduct),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(0, 41),
                textStyle: theme.textTheme.button?.copyWith(fontSize: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(translate('product:text_add_variation')),
            )
          ],
        );
      },
    );
  }
}
