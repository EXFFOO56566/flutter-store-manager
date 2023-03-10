import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';
import 'package:flutter_store_manager/pages/media/view/upload/models/upload_model.dart';
import 'package:media_repository/media_repository.dart';
import 'package:replay_bloc/replay_bloc.dart';

part 'upload_state.dart';

class UploadCubit extends ReplayCubit<UploadState> {
  final UploadModel file;
  final MediaRepository mediaRepository;
  final String token;

  UploadCubit({
    required this.file,
    required this.token,
    required this.mediaRepository,
  }) : super(UploadState(file: file)) {
    postImage();
  }

  /// post Image
  Future<void> postImage() async {
    double progress = 0.0;
    try {
      String path = state.file.path!;
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          path,
          filename: path.split('/').last,
        ),
      });
      Media image = await mediaRepository.postMedia(
        requestData: RequestData(
          query: {
            'app-builder-decode': true,
          },
          data: formData,
          token: token,
          onReceiveProgress: (int sent, int total) {
            progress = sent / total * 100;
            emit(state.copyWith(
              progress: progress,
            ));
          },
        ),
      );
      Map<String, dynamic> media = {
        'id': image.id,
        'src': image.url,
      };
      emit(state.copyWith(media: media));
    } on RequestError catch (e) {
      avoidPrint("error ${e.message}");
    }
  }
}
