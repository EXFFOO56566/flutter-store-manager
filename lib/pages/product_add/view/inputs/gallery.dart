import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Bloc
import '../../bloc/product_add_bloc.dart';
import 'package:flutter_store_manager/common/widgets/image/image.dart';

class ProductGallery extends StatelessWidget {
  const ProductGallery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductAddBloc, ProductAddState>(
      buildWhen: (previous, current) => previous.gallery != current.gallery,
      builder: (context, state) {
        return Column(
          children: [
            ImagesPickerInput(
              label: AppLocalizations.of(context)!.translate('inputs:text_image_gallery'),
              onChanged: (List<ImageData> images) => context.read<ProductAddBloc>().add(GalleryChanged(images)),
              onDeleted: (ImageData item) => context.read<ProductAddBloc>().add(ImageDeletedGalleryChanged(item)),
              value: state.gallery.value,
            )
          ],
        );
      },
    );
  }
}
