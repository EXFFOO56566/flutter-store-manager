import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Bloc
import 'package:flutter_store_manager/types/types.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Themes
import 'package:flutter_store_manager/themes.dart';

import '../../bloc/variation_bloc.dart';

class VariationStockStatus extends StatelessWidget {
  const VariationStockStatus({Key? key}) : super(key: key);

  Option getValue(String key, List<Option> data) {
    Option select = data.firstWhere((o) => key == o.key);
    return select;
  }

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    List<Option> options = [
      Option(key: 'instock', name: translate('product:text_instock')),
      Option(key: 'outofstock', name: translate('product:text_out_stock')),
      Option(key: 'onbackorder', name: translate('product:text_onbackorder')),
    ];

    return BlocBuilder<VariationBloc, VariationState>(
      buildWhen: (previous, current) => previous.stockStatus != current.stockStatus,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabelInput(title: translate('product:text_stock_status')),
            InputDropdown2(
              value: getValue(state.stockStatus.value, options),
              onChanged: (value) => context.read<VariationBloc>().add(StockStatusChanged(value.key)),
              options: options,
            ),
          ],
        );
      },
    );
  }
}
