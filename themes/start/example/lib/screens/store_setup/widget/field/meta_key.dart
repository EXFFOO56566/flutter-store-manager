import 'package:flutter/material.dart';

// Utils

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:example/screens/store_setup/bloc/store_setting_bloc.dart';
import 'package:ui/ui.dart';

class MetaKeyWidget extends StatelessWidget {
  MetaKeyWidget({Key? key}) : super(key: key);
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreSettingBloc, StoreSettingState>(
      buildWhen: (previous, current) => previous.metaKey != current.metaKey,
      builder: (context, state) {
        return InputTextField(
          focusNode: _focusNode,
          label: "Meta Key",
          controller: TextEditingController(text: state.metaKey ?? ""),
          maxLines: 5,
          onChanged: (metaKey) {
            _focusNode.addListener(() {
              if (!_focusNode.hasFocus) {
                context.read<StoreSettingBloc>().add(MetaKeyChanged(metaKey));
              }
            });
          },
        );
      },
    );
  }
}
