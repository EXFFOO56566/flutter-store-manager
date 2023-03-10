// Themes & UI
import 'package:flutter/material.dart';

import 'package:flutter_store_manager/themes.dart';
import 'package:community_material_icon/community_material_icon.dart';

// Localization
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/pages/auth/register/bloc/register_bloc.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({Key? key}) : super(key: key);

  @override
  PasswordInputState createState() => PasswordInputState();
}

class PasswordInputState extends State<PasswordInput> {
  bool _obscureText = true;
  FocusNode? _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _passwordFocusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return InputTextField(
          label: AppLocalizations.of(context)!.translate('inputs:text_password'),
          focusNode: _passwordFocusNode,
          onChanged: (password) => context.read<RegisterBloc>().add(PasswordChanged(password)),
          obscureText: _obscureText,
          decoration: InputDecoration(
            errorText:
                state.password.invalid ? AppLocalizations.of(context)!.translate('validate:text_password') : null,
            prefixIcon: Icon(
              CommunityMaterialIcons.lock,
              size: 20,
              color: Theme.of(context).textTheme.overline?.color,
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
                _obscureText ? CommunityMaterialIcons.eye_outline : CommunityMaterialIcons.eye_off,
                size: 20,
                color: Theme.of(context).textTheme.overline?.color,
              ),
            ),
          ),
        );
      },
    );
  }
}
