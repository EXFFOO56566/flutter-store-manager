import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../../../../widgets/select_image.dart';
import 'status_view.dart';

List<Option> _attributeOptions = const [
  Option(key: 'a', name: 'Any attr'),
  Option(key: 'red', name: 'Red'),
  Option(key: 'pink', name: 'Pink'),
];

List<Option> _classOptions = const [
  Option(key: 'a', name: 'Same as Parent'),
  Option(key: 'red', name: 'Red'),
  Option(key: 'pink', name: 'Pink'),
];

class VariantForm extends StatefulWidget {
  const VariantForm({Key? key}) : super(key: key);

  @override
  State<VariantForm> createState() => _VariantFormState();
}

class _VariantFormState extends State<VariantForm> {
  bool _showExpend = true;

  bool _active = true;
  bool _download = true;
  bool _virtual = true;
  bool _managerStock = true;

  Widget buildExpend(ThemeData theme) {
    return InkWell(
      onTap: () => setState(() {
        _showExpend = !_showExpend;
      }),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Flexible(child: Text('Expend')),
                Icon(
                  _showExpend ? CommunityMaterialIcons.chevron_down : CommunityMaterialIcons.chevron_right,
                  color: theme.textTheme.caption?.color,
                ),
              ],
            ),
          ),
          const Divider(thickness: 1, height: 1),
        ],
      ),
    );
  }

  Widget buildFormExpend(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text('Enable', style: theme.textTheme.bodyText2),
          contentPadding: EdgeInsets.zero,
          leading: CupertinoSwitch(
            value: _active,
            onChanged: (_) => setState(() {
              _active = !_active;
            }),
          ),
          horizontalTitleGap: 11,
          minLeadingWidth: 0,
        ),
        const Divider(height: 1, thickness: 1),
        ListTile(
          title: Text('Downloadable', style: theme.textTheme.bodyText2),
          contentPadding: EdgeInsets.zero,
          leading: CupertinoSwitch(
            value: _download,
            onChanged: (_) => setState(() {
              _download = !_download;
            }),
          ),
          horizontalTitleGap: 11,
          minLeadingWidth: 0,
        ),
        const Divider(height: 1, thickness: 1),
        ListTile(
          title: Text('Virtual', style: theme.textTheme.bodyText2),
          contentPadding: EdgeInsets.zero,
          leading: CupertinoSwitch(
            value: _virtual,
            onChanged: (_) => setState(() {
              _virtual = !_virtual;
            }),
          ),
          horizontalTitleGap: 11,
          minLeadingWidth: 0,
        ),
        const Divider(height: 1, thickness: 1),
        ListTile(
          title: Text('Manage Stock', style: theme.textTheme.bodyText2),
          contentPadding: EdgeInsets.zero,
          leading: CupertinoSwitch(
            value: _managerStock,
            onChanged: (_) => setState(() {
              _managerStock = !_managerStock;
            }),
          ),
          horizontalTitleGap: 11,
          minLeadingWidth: 0,
        ),
        const Divider(height: 1, thickness: 1),
        const SizedBox(height: 16),
        const SelectImage(label: 'Image'),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Expanded(child: InputTextField(label: 'Regular Price')),
            SizedBox(width: 12),
            Expanded(child: InputTextField(label: 'Sale Price')),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Expanded(child: InputTextField(label: 'SKU')),
            SizedBox(width: 12),
            Expanded(child: InputTextField(label: 'Stock Quantity')),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Expanded(child: InputTextField(label: 'Weight (kg)')),
            SizedBox(width: 12),
            Expanded(child: InputTextField(label: 'Length (cm)')),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Expanded(child: InputTextField(label: 'Width (cm)')),
            SizedBox(width: 12),
            Expanded(child: InputTextField(label: 'Height (cm)')),
          ],
        ),
        const SizedBox(height: 16),
        const LabelInput(title: 'Shipping class'),
        InputDropdown(onChanged: (_) {}, options: _classOptions, value: 'a'),
        const SizedBox(height: 16),
        const LabelInput(title: 'Tax Class'),
        InputDropdown(onChanged: (_) {}, options: _classOptions, value: 'a'),
        const SizedBox(height: 16),
        const InputTextField(label: 'Description', minLines: 5),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return ExpansionView(
      title: const Text('Variant 1'),
      isSecondary: true,
      trailing: StatusView(isActive: _active),
      expandedAlignment: AlignmentDirectional.topStart,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      childrenPadding: const EdgeInsets.only(top: 12),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: InputDropdown(
                value: 'a',
                options: _attributeOptions,
                onChanged: (_) {},
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: InputDropdown(
                value: 'a',
                options: _attributeOptions,
                onChanged: (_) {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: InputDropdown(
                value: 'a',
                options: _attributeOptions,
                onChanged: (_) {},
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: InputDropdown(
                value: 'a',
                options: _attributeOptions,
                onChanged: (_) {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        buildExpend(theme),
        if (_showExpend)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: buildFormExpend(theme),
          ),
      ],
    );
  }
}
