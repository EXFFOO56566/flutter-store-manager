import 'package:flutter/material.dart';

// Utils

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import '../../bloc/product_add_bloc.dart';

// Themes
import 'package:flutter_store_manager/themes.dart';

import '../../models/regular_sale.dart';

class ProductRegularPrice extends StatelessWidget {
  const ProductRegularPrice({Key? key}) : super(key: key);

  String getTextError(RegularPriceValidationError error, TranslateType translate) {
    switch (error) {
      case RegularPriceValidationError.error:
        return translate('validate:text_number');
      default:
        return translate('validate:text_title');
    }
  }

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    return BlocBuilder<ProductAddBloc, ProductAddState>(
      buildWhen: (previous, current) => previous.regularPrice != current.regularPrice,
      builder: (context, state) {
        return InputTextField(
          initialValue: state.regularPrice.value,
          label: translate('inputs:text_regular'),
          onChanged: (regularPrice) => context.read<ProductAddBloc>().add(RegularPriceChanged(regularPrice)),
          decoration: InputDecoration(
            errorText: state.regularPrice.invalid ? getTextError(state.regularPrice.error!, translate) : null,
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        );
      },
    );
  }
}
