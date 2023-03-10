import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/pages/update_personal/bloc/update_personal_bloc.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Bloc
import 'package:flutter_store_manager/common/widgets/image/image.dart';

class UpdatePersonalImage extends StatelessWidget {
  const UpdatePersonalImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdatePersonalBloc, UpdatePersonalState>(
      buildWhen: (previous, current) => previous.image != current.image,
      builder: (context, state) {
        return Column(
          children: [
            ImagePickerInput(
              label: AppLocalizations.of(context)!.translate('inputs:text_avatar'),
              onChanged: (ImageData i) => context.read<UpdatePersonalBloc>().add(ImageChanged(i, isSelectdImage: true)),
              onDeleted: () => context.read<UpdatePersonalBloc>().add(const ImageDeletedChanged()),
              value: state.image.value,
            )
          ],
        );
      },
    );
  }
}
