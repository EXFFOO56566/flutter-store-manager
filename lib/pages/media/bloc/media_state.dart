part of 'media_cubit.dart';

class MediaState extends BaseState {
  final List<dynamic> data;
  final BaseState actionState;
  final int page;
  final bool isSwitchSelect;
  final bool isSelect;
  final bool isSelectMulti;
  final List<dynamic> mediaSelected;

  // The state delete the media
  final String deleting;

  const MediaState({
    this.data = const [],
    this.actionState = const InitState(),
    this.page = 0,
    this.isSwitchSelect = true,
    this.isSelect = true,
    this.isSelectMulti = true,
    this.mediaSelected = const [],
    this.deleting = 'idea',
  });

  @override
  List<Object?> get props => [
        data,
        page,
        actionState,
        isSwitchSelect,
        isSelect,
        isSelectMulti,
        mediaSelected,
        deleting,
      ];

  MediaState copyWith({
    List<dynamic>? data,
    BaseState? actionState,
    int? page,
    bool? isSwitchSelect,
    bool? isSelect,
    bool? isSelectMulti,
    List<dynamic>? mediaSelected,
    String? deleting,
  }) {
    return MediaState(
      data: data ?? this.data,
      actionState: actionState ?? this.actionState,
      page: page ?? this.page,
      isSwitchSelect: isSwitchSelect ?? this.isSwitchSelect,
      isSelect: isSelect ?? this.isSelect,
      isSelectMulti: isSelect ?? this.isSelectMulti,
      mediaSelected: mediaSelected ?? this.mediaSelected,
      deleting: deleting ?? this.deleting,
    );
  }
}
