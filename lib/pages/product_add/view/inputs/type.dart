import 'package:flutter/material.dart';

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';

// Themes
import 'package:flutter_store_manager/themes.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

import '../../bloc/product_add_bloc.dart';

class ProductTypeView extends StatefulWidget {
  const ProductTypeView({Key? key}) : super(key: key);

  @override
  ProductTypeViewState createState() => ProductTypeViewState();
}

class ProductTypeViewState extends State<ProductTypeView> {
  Option _getOptionByKey(String key, List<Option> options) {
    Option select = options.firstWhere((o) => key == o.key);
    return select;
  }

  List<Option> _getOptions(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    return [
      Option(key: 'simple', name: translate('product:text_simple_product')),
      Option(key: 'variable', name: translate('product:text_variable')),
      Option(key: 'grouped', name: translate('product:text_group')),
      Option(key: 'external', name: translate('product:text_external')),
    ];
  }

  void _onChanged(Option value) {
    context.read<ProductAddBloc>().add(TypeChanged(value.key));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductAddBloc, ProductAddState>(
      buildWhen: (previous, current) => previous.type != current.type,
      builder: (context, state) {
        List<Option> options = _getOptions(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputDropdown2(
              value: _getOptionByKey(state.type.value, options),
              options: options,
              onChanged: _onChanged,
            ),
            const SizedBox(height: 15),
          ],
        );
      },
    );
  }
}
