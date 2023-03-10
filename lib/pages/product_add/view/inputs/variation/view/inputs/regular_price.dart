import 'package:flutter/material.dart';

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';

// Themes
import 'package:flutter_store_manager/themes.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:flutter_store_manager/types/types.dart';

import '../../bloc/variation_bloc.dart';
import '../../model/regular_price.dart';

class VariationRegularPrice extends StatelessWidget {
  const VariationRegularPrice({Key? key}) : super(key: key);

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
    return BlocBuilder<VariationBloc, VariationState>(
      buildWhen: (previous, current) => previous.regularPrice != current.regularPrice,
      builder: (context, state) {
        return InputTextField(
          initialValue: state.regularPrice.value,
          label: translate('inputs:text_regular'),
          onChanged: (regularPrice) => context.read<VariationBloc>().add(RegularPriceChanged(regularPrice)),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            errorText: state.regularPrice.invalid ? getTextError(state.regularPrice.error!, translate) : null,
          ),
        );
      },
    );
  }
}
