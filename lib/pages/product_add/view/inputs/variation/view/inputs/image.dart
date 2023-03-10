import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/common/widgets/image/image.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

import '../../bloc/variation_bloc.dart';

class VariationImage extends StatelessWidget {
  const VariationImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VariationBloc, VariationState>(
      buildWhen: (previous, current) => previous.image != current.image,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabelInput(title: AppLocalizations.of(context)!.translate('inputs:text_image_variation')),
            ImagePickerInput(
              value: state.image.value,
              onChanged: (image) => context.read<VariationBloc>().add(ImageChanged(image)),
              onDeleted: () => context.read<VariationBloc>().add(const ImageChanged(null)),
            ),
          ],
        );
      },
    );
  }
}
