import 'package:flutter/material.dart';

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import '../../bloc/product_add_bloc.dart';

// Widget
import 'package:flutter_store_manager/common/widgets/input_html_editor/input_html_editor.dart';

class ProductDescription extends StatefulWidget {
  const ProductDescription({Key? key}) : super(key: key);

  @override
  ProductDescriptionState createState() => ProductDescriptionState();
}

class ProductDescriptionState extends State<ProductDescription> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductAddBloc, ProductAddState>(
      buildWhen: (previous, current) => previous.description != current.description,
      builder: (context, state) {
        return InputHtmlEditor(
          label: AppLocalizations.of(context)!.translate('inputs:text_description'),
          value: state.description.value,
          onChanged: (value) => context.read<ProductAddBloc>().add(DescriptionChanged(value)),
        );
      },
    );
  }
}
