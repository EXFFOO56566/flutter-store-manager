import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../../widgets/select_image.dart';

class SettingStoreForm extends StatelessWidget {
  const SettingStoreForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        InputTextField(
          label: 'Store Name',
          isRequired: true,
        ),
        SizedBox(height: 15),
        InputTextField(
          label: 'Store Email',
          isRequired: true,
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 15),
        InputTextField(
          label: 'Store Phone',
          keyboardType: TextInputType.phone,
        ),
        SizedBox(height: 15),
        InputTextField(
          label: 'Shop Description',
          maxLines: 5,
        ),
        SizedBox(height: 15),
        SelectImage(label: 'Store Logo'),
        SizedBox(height: 15),
        SelectImage(label: 'Store Banner'),
        SizedBox(height: 15),
        SelectImage(label: 'Mobile Banner'),
      ],
    );
  }
}
