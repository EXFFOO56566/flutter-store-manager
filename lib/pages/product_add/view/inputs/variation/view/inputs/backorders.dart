import 'package:flutter/material.dart';

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/variation_bloc.dart';

import 'package:flutter_store_manager/types/types.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Themes
import 'package:flutter_store_manager/themes.dart';

class VariationBackorders extends StatelessWidget {
  const VariationBackorders({Key? key}) : super(key: key);

  Option getValue(String key, List<Option> data) {
    Option select = data.firstWhere((o) => key == o.key);
    return select;
  }

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;

    List<Option> options = [
      Option(key: 'no', name: translate('product:text_backorders_no')),
      Option(key: 'notify', name: translate('product:text_backorders_notify')),
      Option(key: 'yes', name: translate('product:text_backorders_yes')),
    ];

    return BlocBuilder<VariationBloc, VariationState>(
      buildWhen: (previous, current) => previous.backorders != current.backorders,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabelInput(title: translate('product:text_allow_backorders')),
            InputDropdown2(
              value: getValue(state.backorders.value, options),
              onChanged: (value) => context.read<VariationBloc>().add(BackordersChanged(value.key)),
              options: options,
            ),
          ],
        );
      },
    );
  }
}
