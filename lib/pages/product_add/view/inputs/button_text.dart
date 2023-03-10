import 'package:flutter/material.dart';

// Utils
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/product_add_bloc.dart';

// Themes
import 'package:flutter_store_manager/themes.dart';

class ProductButtonText extends StatelessWidget {
  static const List<String> visible = ['external'];

  const ProductButtonText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductAddBloc, ProductAddState>(
      buildWhen: (previous, current) => previous.buttonText != current.buttonText,
      builder: (context, state) {
        return InputTextField(
          initialValue: state.buttonText.value,
          label: AppLocalizations.of(context)!.translate('inputs:text_button_text'),
          onChanged: (name) => context.read<ProductAddBloc>().add(ButtonTextChanged(name)),
        );
      },
    );
  }
}
