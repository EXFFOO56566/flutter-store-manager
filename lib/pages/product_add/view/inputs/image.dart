import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Bloc
import '../../bloc/product_add_bloc.dart';
import 'package:flutter_store_manager/common/widgets/image/image.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductAddBloc, ProductAddState>(
      buildWhen: (previous, current) => previous.image != current.image,
      builder: (context, state) {
        return Column(
          children: [
            ImagePickerInput(
              label: AppLocalizations.of(context)!.translate('inputs:text_image'),
              onChanged: (ImageData i) => context.read<ProductAddBloc>().add(ImageChanged(i)),
              onDeleted: () => context.read<ProductAddBloc>().add(const ImageDeletedChanged()),
              value: state.image.value,
            )
          ],
        );
      },
    );
  }
}
