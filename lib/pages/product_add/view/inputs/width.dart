import 'package:flutter/material.dart';

// Utils

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import '../../bloc/product_add_bloc.dart';

// Themes
import 'package:flutter_store_manager/themes.dart';

class ProductWidth extends StatelessWidget {
  const ProductWidth({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductAddBloc, ProductAddState>(
      builder: (context, state) {
        return InputTextField(
          label: AppLocalizations.of(context)!.translate('inputs:text_width'),
          onChanged: (width) => context.read<ProductAddBloc>().add(WidthChanged(width)),
          keyboardType: TextInputType.number,
        );
      },
    );
  }
}
