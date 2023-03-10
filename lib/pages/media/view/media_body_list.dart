import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';
import 'package:flutter_store_manager/common/widgets/base_smart_fresher.dart';
import 'package:flutter_store_manager/pages/media/media.dart';
import 'package:flutter_store_manager/pages/media/view/upload/models/upload_model.dart';
import 'package:flutter_store_manager/pages/media/view/upload/view/upload_file.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:media_repository/media_repository.dart';

import 'media_item.dart';
import 'media_item_select.dart';

class MediaBodyList extends StatefulWidget {
  final GetFromGalleryType? getFromGalleryType;
  const MediaBodyList({Key? key, this.getFromGalleryType}) : super(key: key);

  @override
  MediaBodyListState createState() => MediaBodyListState();
}

class MediaBodyListState extends State<MediaBodyList> {
  late MediaCubit cubit;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    cubit = context.read<MediaCubit>();
    cubit.initGetType(type: widget.getFromGalleryType);
    cubit.getMedia();
    if (cubit.state.actionState is! LoadingState) {
      cubit.getMedia();
    }
    super.didChangeDependencies();
  }

  Future _loadMore() async {
    await cubit.loadMore();
  }

  Future _refresh() async {
    await cubit.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediaCubit, MediaState>(
      builder: (context, state) {
        if (state.actionState is! LoadingState && state.data.isEmpty) {
          TranslateType translate = AppLocalizations.of(context)!.translate;
          return NotificationEmptyView(
            icon: CommunityMaterialIcons.image_multiple,
            title: translate('media:text_empty'),
          );
        }

        MediaQueryData mediaQuery = MediaQuery.of(context);
        List<Media> emptyMedia = List.generate(10, (index) => Media(id: 0)).toList();
        List<dynamic> data = state.actionState is LoadingState ? emptyMedia : state.data;

        double bottom = state.isSelect ? mediaQuery.padding.bottom : 0;

        return Padding(
          padding: EdgeInsets.only(bottom: bottom),
          child: BaseSmartFresher(
            onRefresh: _refresh,
            onLoadMore: cubit.canLoadMore ? _loadMore : null,
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(25, 12, 25, 25),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemCount: data.length,
              itemBuilder: (BuildContext ctx, index) {
                dynamic item = data[index];
                Widget child;
                if (item is UploadModel) {
                  child = UploadFile(
                    file: item,
                    uploadSuccess: (Map<String, dynamic> image) {
                      context.read<MediaCubit>().uploadSuccess(
                            item: item,
                            image: image,
                          );
                    },
                  );
                } else {
                  child = LayoutBuilder(
                    builder: (_, BoxConstraints constraints) {
                      if (state.isSelect) {
                        return MediaItemSelect(
                          item: item,
                          width: constraints.maxWidth,
                          height: constraints.maxHeight,
                        );
                      }
                      return MediaItem(
                        item: item,
                        width: constraints.maxWidth,
                        height: constraints.maxHeight,
                        radius: 8,
                      );
                    },
                  );
                }
                return Container(
                  key: Key('${item.id}'),
                  child: child,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
