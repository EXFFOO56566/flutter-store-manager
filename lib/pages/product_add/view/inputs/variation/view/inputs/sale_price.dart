import 'package:flutter/material.dart';

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/types/types.dart';
import '../../bloc/variation_bloc.dart';

// Themes
import 'package:flutter_store_manager/themes.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

import '../../model/sale_price.dart';

class VariationSalePrice extends StatelessWidget {
  const VariationSalePrice({Key? key}) : super(key: key);

  String getTextError(SalePriceValidationError error, TranslateType translate) {
    switch (error) {
      case SalePriceValidationError.error:
        return translate('validate:text_number');
      default:
        return translate('validate:text_sale_price');
    }
  }

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    return BlocBuilder<VariationBloc, VariationState>(
      buildWhen: (previous, current) =>
          previous.salePrice != current.salePrice || previous.regularPrice != current.regularPrice,
      builder: (context, state) {
        return InputTextField(
          label: translate('inputs:text_sale'),
          initialValue: state.salePrice.value,
          onChanged: (salePrice) => context.read<VariationBloc>().add(SalePriceChanged(salePrice)),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            errorText: state.salePrice.invalid ? getTextError(state.salePrice.error!, translate) : null,
          ),
        );
      },
    );
  }
}
