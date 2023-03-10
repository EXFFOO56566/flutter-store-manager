// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter_bloc/flutter_bloc.dart';

// Bloc
import '../../../../../bloc/store_setting_bloc.dart';

// Themes
import 'package:flutter_store_manager/themes.dart';

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
          label: AppLocalizations.of(context)!.translate('inputs:text_policy_label'),
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
