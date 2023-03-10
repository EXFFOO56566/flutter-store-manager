part of 'upload_cubit.dart';

class UploadState extends BaseState {
  final double progress;
  final UploadModel file;
  final Map<String, dynamic>? media;

  const UploadState({
    this.progress = 0.0,
    required this.file,
    this.media = const {},
  });

  @override
  List<Object?> get props => [progress, media];

  UploadState copyWith({
    double? progress,
    Map<String, dynamic>? media,
  }) {
    return UploadState(
      progress: progress ?? this.progress,
      file: file,
      media: media ?? this.media,
    );
  }
}
