import 'dart:async';

import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';
import 'package:flutter_store_manager/pages/media/media.dart';
import 'package:flutter_store_manager/utils/query.dart';
import 'package:media_repository/media_repository.dart';
import 'package:replay_bloc/replay_bloc.dart';

import '../view/upload/models/upload_model.dart';

part 'media_state.dart';

class MediaCubit extends ReplayCubit<MediaState> {
  final String vendor;
  final pageSize = 20;
  final MediaRepository mediaRepository;

  GetFromGalleryType getFromGalleryType = GetFromGalleryType.notGet;
  final String token;
  MediaCubit({
    required this.mediaRepository,
    required this.vendor,
    required this.token,
    bool isSwitchSelect = true,
    bool isSelect = true,
    bool isSelectMulti = true,
  }) : super(
          MediaState(
            data: const [],
            mediaSelected: const [],
            isSwitchSelect: isSwitchSelect,
            isSelect: isSelect,
            isSelectMulti: isSelectMulti,
          ),
        );

  void onDataPhotoLibrary(List<UploadModel> dataPhotoLibrary) async {
    List<dynamic> newData = List<dynamic>.of(state.data);
    emit(state.copyWith(
      data: [...dataPhotoLibrary, ...newData],
    ));
  }

  void uploadSuccess({required dynamic item, required Map<String, dynamic> image}) {
    List<dynamic> images = List<dynamic>.of(state.data);

    int index = images.indexWhere((e) {
      return e.id == item.id;
    });

    if (index >= 0) {
      images.removeAt(index);
      images.insert(
        index,
        Media(
          id: image['id'],
          url: image['src'],
        ),
      );
    }

    emit(state.copyWith(data: images));
  }

  Future<void> getMedia({String? keyword}) async {
    emit(state.copyWith(
      actionState: const LoadingState(),
    ));
    await _getMedia(page: 1);
  }

  void initGetType({required GetFromGalleryType? type}) {
    if (type != null) {
      getFromGalleryType = type;
    }
  }

  void changeIsSelect({bool? isSelect}) {
    emit(state.copyWith(isSelect: isSelect, mediaSelected: []));
  }

  void setMedia({Media? media}) {
    if (media != null) {
      if (state.isSelectMulti) {
        List<Media> data = [
          ...state.mediaSelected,
        ];
        bool exist = data.contains(media);
        if (exist) {
          data.remove(media);
        } else {
          data.add(media);
        }
        emit(state.copyWith(mediaSelected: data));
      } else {
        emit(state.copyWith(
          mediaSelected: [media],
        ));
      }
    }
  }

  Future<void> refresh() async {
    await _getMedia(page: 1);
  }

  Future<void> loadMore() async {
    await _getMedia(page: state.page + 1);
  }

  Future<void> _getMedia({int page = 1, int? perPage}) async {
    try {
      Map<String, dynamic> queryParameters = {
        'author': vendor,
        'page': page,
        'per_page': perPage ?? pageSize,
        'app-builder-decode': true,
      };

      List<Media> data = await mediaRepository.getMedia(
        requestData: RequestData(
          query: preQueryParameters(queryParameters),
          token: token,
        ),
      );

      var newMedia = state.data;
      if (page == 1) {
        newMedia = data;
      } else {
        newMedia.addAll(data);
      }
      emit(
        state.copyWith(
          actionState: LoadedState(data: newMedia.length),
          data: newMedia,
          page: page,
        ),
      );
      switch (getFromGalleryType) {
        case GetFromGalleryType.aPic:
          if (!state.isSelect) {
            emit(state.copyWith(isSelect: true, mediaSelected: []));
          }
          break;
        default:
          break;
      }
    } on RequestError catch (e) {
      emit(state.copyWith(actionState: ErrorState(data: e.message)));
    }
  }

  /// Delete media
  Future<void> deleteMedia(int? id) async {
    emit(state.copyWith(deleting: 'pending'));
    try {
      await mediaRepository.deleteMedia(
        id: id ?? 0,
        requestData: RequestData(
          token: token,
          query: {
            'force': true,
            'app-builder-decode': true,
          },
        ),
      );
      await refresh();

      List<dynamic> newMediaSelected = List<dynamic>.of(state.mediaSelected);
      newMediaSelected.removeWhere((e) => e.id == id);
      emit(state.copyWith(mediaSelected: newMediaSelected, deleting: 'complete'));
    } on RequestError catch (_) {
      emit(state.copyWith(deleting: 'error'));
    }
  }

  Future<void> onDeleteDefault(String? deleting) async {
    emit(state.copyWith(deleting: deleting));
  }

  /// Delete multiple media
  Future<void> deleteMultiMedia() async {
    List<dynamic> mediaSelected = state.mediaSelected;
    emit(state.copyWith(deleting: 'pending'));

    try {
      // Delete  media from your call api
      int j = -1;
      await Future.doWhile(() async {
        j++;
        if (j < mediaSelected.length && mediaSelected[j] is Media) {
          await mediaRepository.deleteMedia(
            id: mediaSelected[j].id,
            requestData: RequestData(
              query: {
                'force': true,
                'app-builder-decode': true,
              },
              token: token,
            ),
          );

          return true;
        }
        return false;
      });

      await refresh();

      emit(state.copyWith(
        mediaSelected: [],
        deleting: 'complete',
      ));
    } on RequestError catch (_) {
      emit(state.copyWith(deleting: 'error'));
    }
  }

  bool get canLoadMore => state.data.length >= (state.page * pageSize);
}
