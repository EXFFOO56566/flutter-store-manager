import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/authentication/authentication.dart';
import 'package:flutter_store_manager/pages/media/media.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:media_repository/media_repository.dart';

import 'media_list_container.dart';
import 'media_library_page_bottom.dart';

class MediaLibraryPage extends StatelessWidget with AppbarMixin {
  final bool isMulti;
  final ValueChanged<dynamic> onChanged;

  const MediaLibraryPage({
    Key? key,
    this.isMulti = true,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return MediaCubit(
          mediaRepository: MediaRepository(context.read<HttpClient>()),
          vendor: context.read<AuthenticationBloc>().state.user.id,
          token: context.read<AuthenticationBloc>().state.token,
          isSelect: true,
          isSelectMulti: isMulti,
          isSwitchSelect: false,
        );
      },
      child: MediaListContainer(
        bottom: MediaLibraryPageBottom(onChanged: onChanged),
      ),
    );
  }
}
