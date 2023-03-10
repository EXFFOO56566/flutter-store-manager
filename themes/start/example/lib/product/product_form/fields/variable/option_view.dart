import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import 'status_view.dart';
import 'variable_container.dart';

class OptionView extends StatefulWidget {
  final Widget child;

  const OptionView({Key? key, required this.child}) : super(key: key);

  @override
  State<OptionView> createState() => _OptionViewState();
}

class _OptionViewState extends State<OptionView> {
  bool _active = false;
  bool _visitProduct = false;
  bool _useVariation = false;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return VariableContainer(
      children: [
        ExpansionView(
          title: const Text('Color'),
          trailing: StatusView(isActive: _active),
          isSecondary: true,
          expandedAlignment: AlignmentDirectional.topStart,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
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
              title: Text('Visible on the product page', style: theme.textTheme.bodyText2),
              contentPadding: EdgeInsets.zero,
              leading: CupertinoSwitch(
                value: _visitProduct,
                onChanged: (_) => setState(() {
                  _visitProduct = !_visitProduct;
                }),
              ),
              horizontalTitleGap: 11,
              minLeadingWidth: 0,
            ),
            const Divider(height: 1, thickness: 1),
            ListTile(
              title: Text('Use as Variation', style: theme.textTheme.bodyText2),
              contentPadding: EdgeInsets.zero,
              leading: CupertinoSwitch(
                value: _useVariation,
                onChanged: (_) => setState(() {
                  _useVariation = !_useVariation;
                }),
              ),
              horizontalTitleGap: 11,
              minLeadingWidth: 0,
            ),
            widget.child,
          ],
        ),
      ],
    );
  }
}
