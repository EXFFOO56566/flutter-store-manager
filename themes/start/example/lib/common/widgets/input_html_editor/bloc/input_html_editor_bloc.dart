import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:example/blocs/blocs.dart';
import 'package:example/common/model/image_data.dart';

part 'input_html_editor_event.dart';

part 'input_html_editor_state.dart';

class InputHtmlEditorBloc extends Bloc<InputHtmlEditorEvent, InputHtmlEditorState> {
  InputHtmlEditorBloc() : super(const InputHtmlEditorState()) {
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
            Map<String, dynamic> image = {};
            // await requestHelper.uploadSingleImage(
            //   path: imageData.file!.path,
            //   token: token,
            // );
            data.add(image['source_url']);
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
