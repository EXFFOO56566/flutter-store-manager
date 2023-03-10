import 'package:flutter/material.dart';

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import '../../bloc/product_add_bloc.dart';

// Themes
import 'package:flutter_store_manager/themes.dart';

class ProductBackorders extends StatelessWidget {
  static const List<String> visible = ['simple', 'variable'];

  const ProductBackorders({Key? key}) : super(key: key);

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
    return BlocBuilder<ProductAddBloc, ProductAddState>(
      buildWhen: (previous, current) => previous.backorders != current.backorders,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabelInput(title: translate('product:text_allow_backorders')),
            InputDropdown2(
              value: getValue(state.backorders.value, options),
              onChanged: (value) => context.read<ProductAddBloc>().add(BackordersChanged(value.key)),
              options: options,
            ),
            if (state.backorders.invalid) ErrorInput(title: translate('validate:text_backorders')),
          ],
        );
      },
    );
  }
}
