import 'package:flutter/material.dart';

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:flutter_store_manager/types/types.dart';
import '../../bloc/product_add_bloc.dart';

// Themes
import 'package:flutter_store_manager/themes.dart';

class ProductStockQuantity extends StatelessWidget {
  static const List<String> visible = ['simple', 'variable'];

  const ProductStockQuantity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    return BlocBuilder<ProductAddBloc, ProductAddState>(
      buildWhen: (previous, current) => previous.stockQuantity != current.stockQuantity,
      builder: (context, state) {
        return InputTextField(
          label: translate('inputs:text_quantity'),
          initialValue: state.stockQuantity.value,
          onChanged: (value) =>
              context.read<ProductAddBloc>().add(StockQuantityChanged(value.isNotEmpty ? value : null)),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            errorText: state.stockQuantity.invalid ? translate('validate:text_number') : null,
          ),
        );
      },
    );
  }
}
