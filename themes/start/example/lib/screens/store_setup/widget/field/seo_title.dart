import 'package:flutter/material.dart';

// Utils

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:example/screens/store_setup/bloc/store_setting_bloc.dart';
import 'package:ui/ui.dart';

class SeoTitleWidget extends StatelessWidget {
  SeoTitleWidget({Key? key}) : super(key: key);
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreSettingBloc, StoreSettingState>(
      buildWhen: (previous, current) => previous.seoTitle != current.seoTitle,
      builder: (context, state) {
        return InputTextField(
          focusNode: _focusNode,
          label: "Seo Title",
          controller: TextEditingController(text: state.seoTitle ?? ""),
          onChanged: (seoTitle) {
            _focusNode.addListener(() {
              if (!_focusNode.hasFocus) {
                context.read<StoreSettingBloc>().add(SeoTitleChanged(seoTitle));
              }
            });
          },
        );
      },
    );
  }
}
