import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

// Utils

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:example/screens/store_setup/bloc/store_setting_bloc.dart';
import 'package:ui/ui.dart';

class SnapLinkWidget extends StatelessWidget {
  SnapLinkWidget({Key? key}) : super(key: key);
  final _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocBuilder<StoreSettingBloc, StoreSettingState>(
      buildWhen: (previous, current) => previous.snapLink != current.snapLink,
      builder: (context, state) {
        return InputTextField(
          focusNode: _focusNode,
          label: "Snapchat",
          controller: TextEditingController(text: state.snapLink ?? ""),
          decoration: InputDecoration(
            prefixIcon: Icon(
              CommunityMaterialIcons.snapchat,
              size: 20,
              color: theme.textTheme.overline?.color,
            ),
          ),
          onChanged: (snapLink) {
            _focusNode.addListener(() {
              if (!_focusNode.hasFocus) {
                context.read<StoreSettingBloc>().add(SnapLinkChanged(snapLink));
              }
            });
          },
        );
      },
    );
  }
}
