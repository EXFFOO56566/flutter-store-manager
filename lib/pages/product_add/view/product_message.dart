import 'package:flutter/material.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Dependencies
import 'package:formz/formz.dart';

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product_add_bloc.dart';

class ProductMessage extends StatelessWidget {
  const ProductMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductAddBloc, ProductAddState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        TranslateType translate = AppLocalizations.of(context)!.translate;
        if (state.status.isSubmissionSuccess) {
          final text =
              state.enableDraft ? 'message:text_add_product_draft_success' : 'message:text_add_product_success';
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(translate(text)),
              ),
            );
        }
        if (state.status.isSubmissionFailure) {
          final defaultText =
              state.enableDraft ? 'message:text_add_product_draft_fail' : 'message:text_add_product_fail';
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.messageError?.isNotEmpty == true ? state.messageError! : translate(defaultText)),
              ),
            );
        }
      },
      child: const SizedBox(),
    );
  }
}
