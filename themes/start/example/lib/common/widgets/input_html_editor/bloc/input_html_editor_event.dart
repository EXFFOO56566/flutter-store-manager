part of 'input_html_editor_bloc.dart';

abstract class InputHtmlEditorEvent extends Equatable {
  const InputHtmlEditorEvent();

  @override
  List<Object> get props => [];
}

class ImageChanged extends InputHtmlEditorEvent {
  const ImageChanged(this.images);

  final List<ImageData> images;

  @override
  List<Object> get props => [images];
}
