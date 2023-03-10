import 'package:appcheap_flutter_core/utils/utils.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_manager/types/types.dart';
import '../../bloc/update_password_bloc.dart';
import '../../models/models.dart';

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';

// Themes
import 'package:flutter_store_manager/themes.dart';

class ConfirmPasswordField extends StatefulWidget {
  final TextEditingController? controller;

  const ConfirmPasswordField({Key? key, this.controller}) : super(key: key);

  @override
  ConfirmPasswordFieldState createState() => ConfirmPasswordFieldState();
}

class ConfirmPasswordFieldState extends State<ConfirmPasswordField> {
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

  String? getError(ConfirmPassword data, TranslateType translate) {
    if (data.invalid) {
      if (data.error == ConfirmPasswordValidationError.empty) {
        return translate('validate:text_title');
      }

      if (data.error == ConfirmPasswordValidationError.diff) {
        return translate('validate:text_confirm_new');
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;

    return BlocBuilder<UpdatePasswordBloc, UpdatePasswordState>(
      buildWhen: (previous, current) =>
          previous.confirmPassword != current.confirmPassword || previous.newPassword != current.newPassword,
      builder: (context, state) {
        return InputTextField(
          label: translate('inputs:text_confirm_password'),
          isRequired: true,
          controller: widget.controller,
          obscureText: _obscureText,
          onChanged: (value) {
            context.read<UpdatePasswordBloc>().add(ConfirmPasswordChanged(value));
          },
          decoration: InputDecoration(
            errorText: getError(state.confirmPassword, translate),
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
