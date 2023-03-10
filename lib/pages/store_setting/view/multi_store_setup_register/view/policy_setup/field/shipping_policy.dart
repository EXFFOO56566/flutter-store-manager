// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter_store_manager/common/widgets/input_html_editor/input_html_editor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Bloc
import '../../../../../bloc/store_setting_bloc.dart';

class ShippingPolicyWidget extends StatelessWidget {
  ShippingPolicyWidget({Key? key}) : super(key: key);
  final _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreSettingBloc, StoreSettingState>(
      buildWhen: (previous, current) => previous.shippingPolicy != current.shippingPolicy,
      builder: (context, state) {
        return InputHtmlEditor(
          focusNode: _focusNode,
          key: const Key("ship_policy"),
          label: AppLocalizations.of(context)!.translate('inputs:text_shipping_policy'),
          value: state.shippingPolicy ?? "",
          onChanged: (shippingPolicy) {
            _focusNode.addListener(() {
              if (!_focusNode.hasFocus) {
                context.read<StoreSettingBloc>().add(ShippingPolicyChanged(shippingPolicy));
              }
            });
          },
        );
      },
    );
  }
}
