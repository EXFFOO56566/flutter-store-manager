import 'package:example/common/widgets/input_html_editor/input_html_editor.dart';
import 'package:flutter/material.dart';

// Utils

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:example/screens/store_setup/bloc/store_setting_bloc.dart';

// Themes
class CancelPolicyWidget extends StatelessWidget {
  CancelPolicyWidget({Key? key}) : super(key: key);
  final _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreSettingBloc, StoreSettingState>(
      buildWhen: (previous, current) => previous.cancelPolicy != current.cancelPolicy,
      builder: (context, state) {
        return InputHtmlEditor(
          focusNode: _focusNode,
          label: "Return Policy",
          value: state.cancelPolicy ?? "",
          onChanged: (cancelPolicy) {
            _focusNode.addListener(() {
              if (!_focusNode.hasFocus) {
                context.read<StoreSettingBloc>().add(CancelPolicyChanged(cancelPolicy));
              }
            });
          },
        );
      },
    );
  }
}
