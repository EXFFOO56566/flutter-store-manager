import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:ui/ui.dart';

import '../../screens.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _data = {};

  bool _passwordObscureText = true;
  late FocusNode _passwordFocusNode;

  bool _confirmPasswordObscureText = true;
  late FocusNode _confirmPasswordFocusNode;

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  void changeData(String key, String value) {
    setState(() {
      _data = {
        ..._data,
        key: value,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputTextField(
            label: 'Email Address *',
            decoration: InputDecoration(
              prefixIcon: Icon(
                CommunityMaterialIcons.email,
                size: 20,
                color: theme.textTheme.overline?.color,
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            onChanged: (String value) => changeData('email', value),
          ),
          const SizedBox(height: 15),
          InputTextField(
            label: 'Verification Code',
            trailingLabel: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                minimumSize: const Size(0, 0),
                textStyle: theme.textTheme.bodyText2,
                padding: EdgeInsets.zero,
              ),
              child: const Text('Re-send Code'),
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(
                CommunityMaterialIcons.code_array,
                size: 20,
                color: theme.textTheme.overline?.color,
              ),
            ),
            onChanged: (String value) => changeData('verify_code', value),
          ),
          const SizedBox(height: 15),
          InputTextField(
            label: 'Store Name *',
            decoration: InputDecoration(
              prefixIcon: Icon(
                CommunityMaterialIcons.storefront,
                size: 20,
                color: theme.textTheme.overline?.color,
              ),
            ),
            onChanged: (String value) => changeData('storeName', value),
          ),
          const SizedBox(height: 15),
          InputTextField(
            label: 'Password *',
            decoration: InputDecoration(
              prefixIcon: Icon(
                CommunityMaterialIcons.lock,
                size: 20,
                color: theme.textTheme.overline?.color,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _passwordObscureText = !_passwordObscureText;
                  });
                  if (_passwordFocusNode.hasFocus == false) {
                    _passwordFocusNode.unfocus();
                    _passwordFocusNode.canRequestFocus = false;
                  }
                },
                icon: Icon(
                  _passwordObscureText ? CommunityMaterialIcons.eye_outline : CommunityMaterialIcons.eye,
                  size: 16,
                  color: theme.textTheme.overline?.color,
                ),
              ),
            ),
            focusNode: _passwordFocusNode,
            obscureText: _passwordObscureText,
            onChanged: (String value) => changeData('password', value),
          ),
          const SizedBox(height: 15),
          InputTextField(
            label: 'Confirm Password *',
            decoration: InputDecoration(
              prefixIcon: Icon(
                CommunityMaterialIcons.lock,
                size: 20,
                color: theme.textTheme.overline?.color,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _confirmPasswordObscureText = !_confirmPasswordObscureText;
                  });
                  if (_confirmPasswordFocusNode.hasFocus == false) {
                    _confirmPasswordFocusNode.unfocus();
                    _confirmPasswordFocusNode.canRequestFocus = false;
                  }
                },
                icon: Icon(
                  _confirmPasswordObscureText ? CommunityMaterialIcons.eye_outline : CommunityMaterialIcons.eye,
                  size: 16,
                  color: theme.textTheme.overline?.color,
                ),
              ),
            ),
            focusNode: _confirmPasswordFocusNode,
            obscureText: _confirmPasswordObscureText,
            onChanged: (String value) => changeData('confirmPassword', value),
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.pushNamed(context, StoreSetupWcfmScreen.routeName);
                }
              },
              child: const Text('Register'),
            ),
          ),
        ],
      ),
    );
  }
}
