import 'package:example/common/model/image_data.dart';
import 'package:example/common/widgets/image_picker/image_picker_input.dart';
import 'package:flutter/material.dart';

// Utils

// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:example/screens/store_setup/bloc/store_setting_bloc.dart';

class TwitterImage extends StatelessWidget {
  const TwitterImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreSettingBloc, StoreSettingState>(
      buildWhen: (previous, current) => previous.twitterImage != current.twitterImage,
      builder: (context, state) {
        return Column(
          children: [
            ImagePickerInput(
              key: const Key("twitter_img"),
              label: "Twitter Image",
              onChanged: (ImageData i) => context.read<StoreSettingBloc>().add(TwitterImgChangedEvent(i)),
              value: state.twitterImage.value,
              onDeleted: () => context.read<StoreSettingBloc>().add(const TwitterImgDeletedEvent()),
            )
          ],
        );
      },
    );
  }
}
