part of 'input_html_editor_bloc.dart';

class InputHtmlEditorState extends Equatable {
  const InputHtmlEditorState({
    this.status = const InitState(),
    this.imageUrls = const [],
  });

  /// Form data status
  final BaseState status;
  final List<String> imageUrls;

  InputHtmlEditorState copyWith({BaseState? status, List<String>? imageUrls}) {
    return InputHtmlEditorState(
      status: status ?? this.status,
      imageUrls: imageUrls ?? this.imageUrls,
    );
  }

  @override
  List<Object> get props => [status, imageUrls];
}
