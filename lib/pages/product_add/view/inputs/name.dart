import 'package:flutter/material.dart';

// Utils
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/product_add_bloc.dart';

// Themes
import 'package:flutter_store_manager/themes.dart';

class ProductName extends StatelessWidget {
  const ProductName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductAddBloc, ProductAddState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return InputTextField(
          initialValue: state.name.value,
          label: AppLocalizations.of(context)!.translate('inputs:text_name'),
          onChanged: (name) => context.read<ProductAddBloc>().add(NameChanged(name)),
          decoration: InputDecoration(
            errorText: state.name.invalid ? AppLocalizations.of(context)!.translate('validate:text_title') : null,
          ),
        );
      },
    );
  }
}
