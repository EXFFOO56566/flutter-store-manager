import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';
import 'package:flutter_store_manager/common/widgets/image/image.dart';
import 'package:media_repository/media_repository.dart';

part 'input_html_editor_event.dart';

part 'input_html_editor_state.dart';

class InputHtmlEditorBloc extends Bloc<InputHtmlEditorEvent, InputHtmlEditorState> {
  final MediaRepository mediaRepository;
  final String token;

  InputHtmlEditorBloc({
    required this.mediaRepository,
    required this.token,
  }) : super(const InputHtmlEditorState()) {
    on<ImageChanged>(_onImageChanged);
  }

  void _onImageChanged(ImageChanged event, Emitter<InputHtmlEditorState> emit) async {
    try {
      emit(state.copyWith(
        status: const LoadingState(),
        imageUrls: [],
      ));
      List<String> images = await _preImages(event.images);
      emit(state.copyWith(
        imageUrls: images,
        status: const LoadedState(),
      ));
    } catch (e) {
      emit(state.copyWith(
        status: const LoadedState(),
      ));
    }
  }

  Future<List<String>> _preImages(List<ImageData> images) async {
    try {
      final List<String> data = [];
      if (images.isNotEmpty) {
        int i = 0;
        await Future.doWhile(() async {
          ImageData imageData = images[i];
          if (imageData.image != null && imageData.image?.id != null) {
            data.add(imageData.image!.src!);
          }

          if (imageData.file != null && imageData.file?.path != null) {
            String path = imageData.file!.path;
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
              ),
            );
            if (image.url?.isNotEmpty == true) {
              data.add(image.url!);
            }
          }

          i++;
          return i < images.length;
        });
      }
      return data;
    } catch (e) {
      rethrow;
    }
  }
}
