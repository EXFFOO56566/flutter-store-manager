import 'package:flutter/material.dart';
import 'package:flutter_store_manager/common/widgets/input_html_editor/input_html_editor.dart';
import 'package:flutter_store_manager/pages/update_personal/bloc/update_personal_bloc.dart';

// Utils
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalAbout extends StatelessWidget {
  final TextEditingController? aboutController;
  const PersonalAbout({Key? key, this.aboutController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdatePersonalBloc, UpdatePersonalState>(
      buildWhen: (previous, current) => (previous.about != current.about),
      builder: (context, state) {
        return InputHtmlEditor(
          label: AppLocalizations.of(context)!.translate('inputs:text_about'),
          value: state.about.value,
          onChanged: (value) => context.read<UpdatePersonalBloc>().add(AboutChanged(value)),
        );
      },
    );
  }
}
