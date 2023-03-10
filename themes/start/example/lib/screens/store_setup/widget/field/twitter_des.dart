import 'package:example/common/widgets/input_html_editor/input_html_editor.dart';
import 'package:flutter/material.dart';

// Utils

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:example/screens/store_setup/bloc/store_setting_bloc.dart';

// Themes

class TwitterDesWidget extends StatelessWidget {
  TwitterDesWidget({Key? key}) : super(key: key);
  final _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreSettingBloc, StoreSettingState>(
      buildWhen: (previous, current) => previous.twitterDes != current.twitterDes,
      builder: (context, state) {
        return InputHtmlEditor(
          focusNode: _focusNode,
          label: "Twitter Description",
          value: state.twitterDes ?? "",
          onChanged: (twitterDes) {
            _focusNode.addListener(() {
              if (!_focusNode.hasFocus) {
                context.read<StoreSettingBloc>().add(TwitterDesChanged(twitterDes));
              }
            });
          },
        );
      },
    );
  }
}
