// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter_bloc/flutter_bloc.dart';

// Bloc
import '../../../../bloc/store_setting_bloc.dart';

// View
import 'package:flutter_store_manager/common/widgets/image/image.dart';

class StoreMobileBannerImage extends StatelessWidget {
  const StoreMobileBannerImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreSettingBloc, StoreSettingState>(
      buildWhen: (previous, current) => previous.storeMobileBannerImage != current.storeMobileBannerImage,
      builder: (context, state) {
        return Column(
          children: [
            ImagePickerInput(
              key: const Key("store_mobile_banner"),
              label: AppLocalizations.of(context)!.translate('inputs:text_store_mobile_banner'),
              onChanged: (ImageData i) => context.read<StoreSettingBloc>().add(StoreMobileBannerChangedEvent(i)),
              value: state.storeMobileBannerImage.value,
              onDeleted: () => context.read<StoreSettingBloc>().add(const StoreMobileBannerDeletedEvent()),
            )
          ],
        );
      },
    );
  }
}
