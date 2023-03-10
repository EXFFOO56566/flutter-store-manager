import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import 'variation_form.dart';

class FieldVariableVariation extends StatelessWidget {
  const FieldVariableVariation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ExpansionView(
      title: Text('Variations'),
      isSecondary: true,
      expandedAlignment: AlignmentDirectional.topStart,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      childrenPadding: EdgeInsets.only(top: 16),
      children: [VariationForm()],
    );
  }
}
