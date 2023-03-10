import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Themes
import 'package:flutter_store_manager/themes.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

import '../../bloc/variation_bloc.dart';

class VariationTaxClass extends StatelessWidget {
  const VariationTaxClass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Option> options = const [
      Option(key: 'parent', name: 'Same as Parent'),
      Option(key: '', name: 'Standard'),
      Option(key: 'reduced-rate', name: 'Reduced rate'),
      Option(key: 'zero-rate', name: 'Zero rate'),
    ];
    return BlocBuilder<VariationBloc, VariationState>(
      buildWhen: (previous, current) => previous.taxClass != current.taxClass,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabelInput(title: AppLocalizations.of(context)!.translate('inputs:text_tax_class')),
            InputDropdown(
              value: state.taxClass.value,
              onChanged: (value) => context.read<VariationBloc>().add(TaxClassChanged(value)),
              options: options,
            ),
          ],
        );
      },
    );
  }
}
