// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter_store_manager/common/widgets/input_html_editor/input_html_editor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Bloc
import '../../../../../bloc/store_setting_bloc.dart';

class RefundPolicyWidget extends StatelessWidget {
  RefundPolicyWidget({Key? key}) : super(key: key);
  final _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreSettingBloc, StoreSettingState>(
      buildWhen: (previous, current) => previous.refundPolicy != current.refundPolicy,
      builder: (context, state) {
        return InputHtmlEditor(
          focusNode: _focusNode,
          label: AppLocalizations.of(context)!.translate('inputs:text_refund_policy'),
          value: state.refundPolicy ?? "",
          onChanged: (refundPolicy) {
            _focusNode.addListener(() {
              if (!_focusNode.hasFocus) {
                context.read<StoreSettingBloc>().add(RefundPolicyChanged(refundPolicy));
              }
            });
          },
        );
      },
    );
  }
}
