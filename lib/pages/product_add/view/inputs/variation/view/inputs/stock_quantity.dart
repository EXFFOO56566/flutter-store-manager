import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Themes
import 'package:flutter_store_manager/themes.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:flutter_store_manager/types/types.dart';

import '../../bloc/variation_bloc.dart';

class VariationStockQuantity extends StatelessWidget {
  const VariationStockQuantity({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    return BlocBuilder<VariationBloc, VariationState>(
      buildWhen: (previous, current) => previous.stockQuantity != current.stockQuantity,
      builder: (context, state) {
        return InputTextField(
          label: translate('inputs:text_quantity'),
          initialValue: state.stockQuantity.value ?? '',
          onChanged: (value) => context.read<VariationBloc>().add(StockQuantityChanged(value)),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            errorText: state.stockQuantity.invalid ? translate('validate:text_number') : null,
          ),
        );
      },
    );
  }
}
