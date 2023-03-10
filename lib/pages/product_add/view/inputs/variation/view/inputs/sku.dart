import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Themes
import 'package:flutter_store_manager/themes.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

import '../../bloc/variation_bloc.dart';

class VariationSku extends StatelessWidget {
  const VariationSku({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VariationBloc, VariationState>(
      buildWhen: (previous, current) => previous.sku != current.sku,
      builder: (context, state) {
        return InputTextField(
          initialValue: state.sku.value,
          label: AppLocalizations.of(context)!.translate('inputs:text_sku'),
          onChanged: (value) => context.read<VariationBloc>().add(SkuChanged(value)),
        );
      },
    );
  }
}
