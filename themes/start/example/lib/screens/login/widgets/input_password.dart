import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/ui.dart';

import '../bloc/login_bloc.dart';

class InputPassword extends StatefulWidget {
  const InputPassword({Key? key}) : super(key: key);

  @override
  State<InputPassword> createState() => _InputPassword();
}

class _InputPassword extends State<InputPassword> {
  bool _obscureText = true;
  late FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return InputTextField(
          label: 'Password',
          focusNode: _passwordFocusNode,
          decoration: InputDecoration(
            hintText: 'vendor',
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
                if (_passwordFocusNode.hasFocus == false) {
                  _passwordFocusNode.unfocus();
                  _passwordFocusNode.canRequestFocus = false;
                }
              },
              icon: Icon(
                _obscureText ? CommunityMaterialIcons.eye_outline : CommunityMaterialIcons.eye_off,
                size: 16,
                color: theme.textTheme.overline?.color,
              ),
            ),
            errorText: state.password.invalid ? 'Fill data' : null,
          ),
          obscureText: _obscureText,
          keyboardType: TextInputType.visiblePassword,
          onChanged: (username) => context.read<LoginBloc>().add(LoginPasswordChanged(username)),
          initialValue: state.password.value,
        );
      },
    );
  }
}
