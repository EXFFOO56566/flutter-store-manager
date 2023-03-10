import 'package:flutter/material.dart';

// Utils

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:example/screens/store_setup/bloc/store_setting_bloc.dart';
import 'package:ui/ui.dart';

// Themes

class TwitterTitleWidget extends StatelessWidget {
  TwitterTitleWidget({Key? key}) : super(key: key);
  final _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreSettingBloc, StoreSettingState>(
      buildWhen: (previous, current) => previous.twitterTitle != current.twitterTitle,
      builder: (context, state) {
        return InputTextField(
          focusNode: _focusNode,
          label: "Twitter Title",
          controller: TextEditingController(text: state.twitterTitle ?? ""),
          onChanged: (twitterTitle) {
            _focusNode.addListener(() {
              if (!_focusNode.hasFocus) {
                context.read<StoreSettingBloc>().add(TwitterTitleChanged(twitterTitle));
              }
            });
          },
        );
      },
    );
  }
}
