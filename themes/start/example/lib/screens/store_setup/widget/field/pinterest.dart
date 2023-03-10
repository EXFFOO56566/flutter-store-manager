import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

// Utils

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:example/screens/store_setup/bloc/store_setting_bloc.dart';
import 'package:ui/ui.dart';

class PinterLinkWidget extends StatelessWidget {
  PinterLinkWidget({Key? key}) : super(key: key);
  final _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocBuilder<StoreSettingBloc, StoreSettingState>(
      buildWhen: (previous, current) => previous.pinterLink != current.pinterLink,
      builder: (context, state) {
        return InputTextField(
          focusNode: _focusNode,
          label: "Pinterest",
          controller: TextEditingController(text: state.pinterLink ?? ""),
          decoration: InputDecoration(
            prefixIcon: Icon(
              CommunityMaterialIcons.pinterest,
              size: 20,
              color: theme.textTheme.overline?.color,
            ),
          ),
          onChanged: (pinterLink) {
            _focusNode.addListener(() {
              if (!_focusNode.hasFocus) {
                context.read<StoreSettingBloc>().add(PinterLinkChanged(pinterLink));
              }
            });
          },
        );
      },
    );
  }
}
