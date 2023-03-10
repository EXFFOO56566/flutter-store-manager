import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:ui/ui.dart';

import '../../screens.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _txtUsernameOrEmail = TextEditingController();
  final _txtPassword = TextEditingController();

  bool _obscureText = true;
  FocusNode? _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _txtUsernameOrEmail.dispose();
    _txtPassword.dispose();
    _passwordFocusNode!.dispose();
    super.dispose();
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
            label: 'Username or Email address',
            decoration: InputDecoration(
              prefixIcon: Icon(
                CommunityMaterialIcons.account,
                size: 20,
                color: theme.textTheme.overline?.color,
              ),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 15),
          InputTextField(
            label: 'Password',
            focusNode: _passwordFocusNode,
            decoration: InputDecoration(
              prefixIcon: Icon(
                CommunityMaterialIcons.lock,
                size: 20,
                color: theme.textTheme.overline?.color,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                  if (_passwordFocusNode!.hasFocus == false) {
                    _passwordFocusNode!.unfocus();
                    _passwordFocusNode!.canRequestFocus = false;
                  }
                },
                icon: Icon(
                  _obscureText ? CommunityMaterialIcons.eye_outline : CommunityMaterialIcons.eye,
                  size: 16,
                  color: theme.textTheme.overline?.color,
                ),
              ),
            ),
            obscureText: _obscureText,
            keyboardType: TextInputType.visiblePassword,
          ),
          const SizedBox(height: 5),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: TextButton(
              onPressed: () => Navigator.pushNamed(context, ForgotPasswordScreen.routeName),
              style: TextButton.styleFrom(
                textStyle: theme.textTheme.overline,
                minimumSize: Size.zero,
                padding: EdgeInsets.zero,
              ),
              child: const Text('Forgot Password?'),
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, HomeScreen.routeName),
              child: const Text('Login'),
            ),
          ),
        ],
      ),
    );
  }
}
