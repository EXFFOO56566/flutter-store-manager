import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

class SettingPersonAddressView extends StatefulWidget {
  final Widget? child;
  final String title;
  final EdgeInsetsGeometry? padding;

  const SettingPersonAddressView({
    Key? key,
    required this.title,
    this.padding,
    this.child,
  }) : super(key: key);

  @override
  State<SettingPersonAddressView> createState() => _SettingPersonAddressViewState();
}

class _SettingPersonAddressViewState extends State<SettingPersonAddressView> {
  bool _isHidden = false;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: widget.padding ?? EdgeInsets.zero,
          child: Row(
            children: [
              Expanded(child: Text(widget.title, style: theme.textTheme.subtitle2)),
              InkResponse(
                onTap: () => setState(() {
                  _isHidden = !_isHidden;
                }),
                child: Icon(
                  _isHidden ? CommunityMaterialIcons.chevron_right : CommunityMaterialIcons.chevron_down,
                  size: 22,
                ),
              )
            ],
          ),
        ),
        Visibility(
          visible: !_isHidden,
          maintainState: true,
          child: widget.child ?? Container(),
        ),
      ],
    );
  }
}
