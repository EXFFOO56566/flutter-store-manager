import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:ui/ui.dart';

import '../../widgets/select_image.dart';

class SettingPersonForm extends StatefulWidget {
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? paddingBottom;

  const SettingPersonForm({
    Key? key,
    this.padding,
    this.paddingBottom,
  }) : super(key: key);

  @override
  State<SettingPersonForm> createState() => _SettingPersonFormState();
}

class _SettingPersonFormState extends State<SettingPersonForm> {
  final _txtPassword = TextEditingController();

  bool _obscureText = true;
  FocusNode? _passwordFocusNode;

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _txtPassword.dispose();
    _passwordFocusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Form(
      child: FixedBottom(
        bottom: ElevatedButton(
          child: const Text('Save'),
          onPressed: () {},
        ),
        paddingBottom: widget.paddingBottom ?? const EdgeInsets.all(25),
        child: SingleChildScrollView(
          padding: widget.padding ?? const EdgeInsets.fromLTRB(25, 8, 25, 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Expanded(
                    child: InputTextField(label: 'First Name'),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: InputTextField(label: 'Last Name'),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const InputTextField(
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 15),
              const InputTextField(
                label: 'Phone',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 15),
              InputTextField(
                label: 'Password',
                controller: _txtPassword,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                      if (_passwordFocusNode?.hasFocus == false) {
                        _passwordFocusNode?.unfocus();
                        _passwordFocusNode?.canRequestFocus = false;
                      }
                    },
                    icon: Icon(
                      _obscureText ? CommunityMaterialIcons.eye_outline : CommunityMaterialIcons.eye,
                      size: 20,
                      color: theme.textTheme.overline?.color,
                    ),
                  ),
                ),
                obscureText: _obscureText,
              ),
              const SizedBox(height: 15),
              const InputTextField(label: 'About', maxLines: 5),
              const SizedBox(height: 15),
              const SelectImage(label: 'Avatar'),
            ],
          ),
        ),
      ),
    );
  }
}
