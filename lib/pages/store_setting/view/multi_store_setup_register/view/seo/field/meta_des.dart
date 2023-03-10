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

class MetaDesWidget extends StatelessWidget {
  MetaDesWidget({Key? key}) : super(key: key);
  final _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreSettingBloc, StoreSettingState>(
      buildWhen: (previous, current) => previous.metaDes != current.metaDes,
      builder: (context, state) {
        return InputTextField(
          focusNode: _focusNode,
          label: AppLocalizations.of(context)!.translate('inputs:text_seo_description'),
          initialValue: state.metaDes ?? "",
          maxLines: 5,
          onChanged: (metaDes) {
            _focusNode.addListener(() {
              if (!_focusNode.hasFocus) {
                context.read<StoreSettingBloc>().add(SeoDesChanged(metaDes));
              }
            });
          },
        );
      },
    );
  }
}
