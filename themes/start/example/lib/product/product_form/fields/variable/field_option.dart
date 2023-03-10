import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import 'option_view.dart';

List<Option> _options = const [
  Option(key: 'red', name: 'Red'),
  Option(key: 'pink', name: 'Pink'),
];

List<Option> _modalOptions = const [
  Option(
    key: '1',
    name: 'Select All',
  ),
  Option(key: 'red', name: 'Red'),
  Option(key: 'pink', name: 'Pink'),
  Option(key: 'blue', name: 'Blue'),
  Option(key: 'yellow', name: 'Yellow'),
  Option(key: 'green', name: 'Green'),
];

class FieldVariableOptionTerm extends StatelessWidget {
  const FieldVariableOptionTerm({Key? key}) : super(key: key);

  void clickModal(BuildContext context) async {
    List<Option>? value = await showModalBottomSheet<List<Option>?>(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        MediaQueryData mediaQuery = MediaQuery.of(context);
        return Container(
          constraints: BoxConstraints(maxHeight: mediaQuery.size.height * 0.8, minHeight: mediaQuery.size.height * 0.5),
          child: ModalMultiOptionApply(
            options: _modalOptions,
            value: _options,
            onChanged: (List<Option> data) => Navigator.pop(context, data),
          ),
        );
      },
    );
    if (value != null) {}
  }

  @override
  Widget build(BuildContext context) {
    return OptionView(
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LabelInput(title: 'Colors'),
            InputGroupOption(
              value: _options,
              onChanged: (_) {},
              trailing: InkResponse(
                onTap: () => clickModal(context),
                child: const Icon(CommunityMaterialIcons.chevron_right),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FieldVariableOptionCustom extends StatelessWidget {
  const FieldVariableOptionCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OptionView(
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            InputTextField(label: 'Name'),
            SizedBox(height: 8),
            InputTextField(
              label: 'Values',
              minLines: 5,
              decoration: InputDecoration(
                hintText: 'Enter some text, some attributes by "|" separating values.',
                hintMaxLines: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
