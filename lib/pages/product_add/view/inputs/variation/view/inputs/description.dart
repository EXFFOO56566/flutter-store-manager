import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Bloc
import '../../bloc/variation_bloc.dart';

import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Widget
import 'package:flutter_store_manager/common/widgets/input_html_editor/input_html_editor.dart';

class VariationDescription extends StatefulWidget {
  const VariationDescription({
    Key? key,
  }) : super(key: key);

  @override
  VariationDescriptionState createState() => VariationDescriptionState();
}

class VariationDescriptionState extends State<VariationDescription> {
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
    return BlocBuilder<VariationBloc, VariationState>(
      buildWhen: (previous, current) => previous.description != current.description,
      builder: (context, state) {
        return InputHtmlEditor(
          label: AppLocalizations.of(context)!.translate('inputs:text_description'),
          value: state.description.value,
          onChanged: (value) => context.read<VariationBloc>().add(DescriptionChanged(value)),
        );
      },
    );
  }
}
