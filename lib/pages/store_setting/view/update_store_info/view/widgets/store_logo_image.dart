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

class StoreLogoImage extends StatelessWidget {
  const StoreLogoImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreSettingBloc, StoreSettingState>(
      buildWhen: (previous, current) => previous.storeLogoImage != current.storeLogoImage,
      builder: (context, state) {
        return Column(
          children: [
            ImagePickerInput(
              key: const Key("store_logo"),
              label: AppLocalizations.of(context)!.translate('inputs:text_store_logo'),
              onChanged: (ImageData i) => context.read<StoreSettingBloc>().add(StoreLogoChangedEvent(i)),
              value: state.storeLogoImage.value,
              onDeleted: () => context.read<StoreSettingBloc>().add(const StoreLogoDeletedEvent()),
            )
          ],
        );
      },
    );
  }
}
