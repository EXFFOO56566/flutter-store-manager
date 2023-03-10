import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Themes
import 'package:flutter_store_manager/themes.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:flutter_store_manager/types/types.dart';

import '../../bloc/variation_bloc.dart';

class VariationLength extends StatelessWidget {
  const VariationLength({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    return BlocBuilder<VariationBloc, VariationState>(
      buildWhen: (previous, current) => previous.length != current.length,
      builder: (context, state) {
        return InputTextField(
          label: translate('inputs:text_length'),
          initialValue: state.length.value,
          onChanged: (value) => context.read<VariationBloc>().add(LengthChanged(value)),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            errorText: state.length.invalid ? translate('validate:text_number') : null,
          ),
        );
      },
    );
  }
}
