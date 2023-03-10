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

class StoreNameWidget extends StatelessWidget {
  StoreNameWidget({Key? key}) : super(key: key);
  final _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreSettingBloc, StoreSettingState>(
      buildWhen: (previous, current) => previous.storeName != current.storeName,
      builder: (context, state) {
        return InputTextField(
          focusNode: _focusNode,
          label: AppLocalizations.of(context)!.translate('inputs:text_store_name'),
          isRequired: true,
          controller: TextEditingController(text: state.storeName.value)
            ..selection = TextSelection.collapsed(offset: state.storeName.value.length),
          onChanged: (name) {
            _focusNode.addListener(() {
              if (!_focusNode.hasFocus) {
                context.read<StoreSettingBloc>().add(StoreNameChanged(name));
              }
            });
          },
          decoration: InputDecoration(
            errorText: state.storeName.invalid ? AppLocalizations.of(context)!.translate('validate:text_title') : null,
          ),
        );
      },
    );
  }
}
