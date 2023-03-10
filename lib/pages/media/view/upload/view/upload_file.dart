import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/pages/media/view/upload/models/upload_model.dart';

// Dependencies
import 'package:flutter_store_manager/authentication/bloc/authentication_bloc.dart';
import 'package:media_repository/media_repository.dart';

// Bloc
import '../bloc/upload_cubit.dart';
import 'media_local.dart';

class UploadFile extends StatelessWidget {
  final UploadModel file;
  final void Function(Map<String, dynamic>) uploadSuccess;

  const UploadFile({
    Key? key,
    required this.file,
    required this.uploadSuccess,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return UploadCubit(
          mediaRepository: MediaRepository(context.read<HttpClient>()),
          token: context.read<AuthenticationBloc>().state.token,
          file: file,
        );
      },
      child: BlocListener<UploadCubit, UploadState>(
        listener: (context, state) {
          if (state.media != null && state.media!['id'] != null) {
            uploadSuccess(state.media!);
          }
        },
        child: const MediaLocal(),
      ),
    );
  }
}
