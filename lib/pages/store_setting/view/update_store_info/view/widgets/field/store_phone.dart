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

class StorePhoneWidget extends StatelessWidget {
  StorePhoneWidget({Key? key}) : super(key: key);
  final _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreSettingBloc, StoreSettingState>(
      buildWhen: (previous, current) => previous.storePhone != current.storePhone,
      builder: (context, state) {
        return InputTextField(
          focusNode: _focusNode,
          controller: TextEditingController(text: state.storePhone ?? "")
            ..selection = TextSelection.collapsed(offset: state.storePhone?.length ?? 0),
          key: const Key("storePhone"),
          label: AppLocalizations.of(context)!.translate('inputs:text_store_phone'),
          onChanged: (phone) {
            _focusNode.addListener(() {
              if (!_focusNode.hasFocus) {
                context.read<StoreSettingBloc>().add(StorePhoneChanged(phone));
              }
            });
          },
        );
      },
    );
  }
}
