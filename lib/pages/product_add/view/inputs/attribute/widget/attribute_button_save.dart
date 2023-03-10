import 'package:appcheap_flutter_core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/pages/product_add/bloc/product_add_bloc.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'package:formz/formz.dart';

class AttributeButtonSave extends StatelessWidget with SnackMixin, LoadingMixin {
  const AttributeButtonSave({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;
    return BlocListener<ProductAddBloc, ProductAddState>(
      listenWhen: (previous, current) => previous.statusAttribute != current.statusAttribute,
      listener: (context, state) {
        if (state.statusAttribute.isSubmissionFailure) {
          showError(
              context,
              state.messageAttributeError ??
                  AppLocalizations.of(context)!.translate('message:text_update_attribute_fail'));
        }
        if (state.statusAttribute.isSubmissionSuccess) {
          showSuccess(context, AppLocalizations.of(context)!.translate('message:text_update_attribute_success'));
        }
      },
      child: BlocBuilder<ProductAddBloc, ProductAddState>(
        buildWhen: (previous, current) => previous.statusAttribute != current.statusAttribute,
        builder: (context, state) {
          return ElevatedButton(
            onPressed: () {
              if (!state.statusAttribute.isSubmissionInProgress) {
                context.read<ProductAddBloc>().add(const ProductAttributeSubmitted());
              }
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(0, 41),
              textStyle: theme.textTheme.button?.copyWith(fontSize: 14),
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: state.statusAttribute.isSubmissionInProgress
                ? buildLoadingElevated()
                : Text(translate('product:text_save_attribute')),
          );
        },
      ),
    );
  }
}
