import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/authentication/authentication.dart';
import 'package:flutter_store_manager/pages/media/media.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:media_repository/media_repository.dart';

import 'media_list_container.dart';
import 'media_list_page_bottom.dart';

enum GetFromGalleryType { notGet, aPic, multiPic }

class MediaListScreen extends StatelessWidget with AppbarMixin {
  static const routeName = '/media_list';
  const MediaListScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GetFromGalleryType? args;
    if (ModalRoute.of(context)?.settings.arguments != null) {
      args = ModalRoute.of(context)?.settings.arguments as GetFromGalleryType;
      avoidPrint("This GetFromMediaType: $args");
    }
    return BlocProvider(
      create: (context) {
        return MediaCubit(
          mediaRepository: MediaRepository(context.read<HttpClient>()),
          vendor: context.read<AuthenticationBloc>().state.user.id,
          token: context.read<AuthenticationBloc>().state.token,
          isSelect: false,
          isSelectMulti: true,
          isSwitchSelect: true,
        );
      },
      child: MediaListContainer(
        getFromGalleryType: args,
        bottom: const MediaListPageBottom(),
      ),
    );
  }
}
