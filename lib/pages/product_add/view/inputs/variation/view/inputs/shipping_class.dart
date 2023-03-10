import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Themes
import 'package:flutter_store_manager/themes.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

import '../../bloc/variation_bloc.dart';

class VariationShippingClass extends StatelessWidget {
  const VariationShippingClass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Option> options = [
      const Option(key: '', name: 'Same as Parent'),
    ];
    return BlocBuilder<VariationBloc, VariationState>(
      buildWhen: (previous, current) => previous.shippingClass != current.shippingClass,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabelInput(title: AppLocalizations.of(context)!.translate('inputs:text_shipping_class')),
            InputDropdown(
              value: state.shippingClass.value,
              onChanged: (value) => context.read<VariationBloc>().add(ShippingClassChanged(value)),
              options: options,
            ),
          ],
        );
      },
    );
  }
}
