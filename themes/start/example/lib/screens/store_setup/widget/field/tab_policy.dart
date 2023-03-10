import 'package:flutter/material.dart';

// Utils

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:example/screens/store_setup/bloc/store_setting_bloc.dart';
import 'package:ui/ui.dart';

// Themes

class TabPolicyWidget extends StatelessWidget {
  TabPolicyWidget({Key? key}) : super(key: key);
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreSettingBloc, StoreSettingState>(
      buildWhen: (previous, current) => previous.policyTab != current.policyTab,
      builder: (context, state) {
        return InputTextField(
          focusNode: _focusNode,
          controller: TextEditingController(text: state.policyTab ?? "")
            ..selection = TextSelection.collapsed(offset: state.policyTab?.length ?? 0),
          label: "Policy Label",
          onChanged: (tabPolicy) {
            _focusNode.addListener(() {
              if (!_focusNode.hasFocus) {
                context.read<StoreSettingBloc>().add(TabPolicyChanged(tabPolicy));
              }
            });
          },
        );
      },
    );
  }
}
