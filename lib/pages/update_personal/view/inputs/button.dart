import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/pages/update_personal/bloc/update_personal_bloc.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:formz/formz.dart';

class PersonalButton extends StatelessWidget with LoadingMixin {
  const PersonalButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdatePersonalBloc, UpdatePersonalState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (!state.status.isSubmissionInProgress) {
                context.read<UpdatePersonalBloc>().add(const Submitted());
              }
            },
            child: state.status.isSubmissionInProgress
                ? buildLoadingElevated()
                : Text(AppLocalizations.of(context)!.translate('common:text_button_save')),
          ),
        );
      },
    );
  }
}
