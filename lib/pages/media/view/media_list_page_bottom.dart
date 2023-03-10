/// Flutter library
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

/// Dependencies
import 'package:flutter_store_manager/pages/media/media.dart';
import 'package:flutter_store_manager/pages/media/view/upload/models/upload_model.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:flutter_store_manager/pages/media/view/media_alert_dialog.dart';

class MediaListPageBottom extends StatefulWidget {
  const MediaListPageBottom({Key? key}) : super(key: key);

  @override
  MediaListPageBottomState createState() => MediaListPageBottomState();
}

class MediaListPageBottomState extends State<MediaListPageBottom> with SnackMixin, LoadingMixin {
  final ImagePicker _picker = ImagePicker();

  void _pickImage() async {
    List<Map<String, dynamic>> uploadImages = [];
    List<UploadModel> upload = [];
    TranslateType translate = AppLocalizations.of(context)!.translate;
    final action = CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () async {
            try {
              XFile? pickedFile = await _picker.pickImage(
                source: ImageSource.camera,
                imageQuality: 50,
                maxWidth: 600,
              );
              uploadImages.add({
                'id': StringGenerate.uuid(),
                'path': pickedFile!.path,
              });
              upload = uploadImages.map((e) => UploadModel.fromJson(e)).toList();
              if (mounted) context.read<MediaCubit>().onDataPhotoLibrary(upload);
              if (mounted) Navigator.pop(context);
            } catch (e) {
              avoidPrint("Err at pick img from camera");
            }
          },
          child: Text(translate('common:text_take_photo')),
        ),
        CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () async {
            try {
              List<XFile>? pickedFiles = await _picker.pickMultiImage(
                imageQuality: 50,
                maxWidth: 600,
              );
              if (pickedFiles?.isNotEmpty == true) {
                for (int i = 0; i < pickedFiles!.length; i++) {
                  uploadImages.add({
                    'id': StringGenerate.uuid(),
                    'path': pickedFiles[i].path,
                  });
                }
                upload = uploadImages.map((e) => UploadModel.fromJson(e)).toList();
                if (mounted) context.read<MediaCubit>().onDataPhotoLibrary(upload);
                if (mounted) Navigator.pop(context);
              }
            } catch (e) {
              avoidPrint("Err at pick img from photo library");
            }
          },
          child: Text(translate('common:text_photo_library')),
        )
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text(translate('common:text_cancel')),
        onPressed: () => Navigator.pop(context),
      ),
    );
    showCupertinoModalPopup(context: context, builder: (context) => action);
  }

  void _delete(BuildContext context) async {
    String? data = await showCupertinoDialog<String?>(
      context: context,
      builder: (BuildContext ctx) {
        return const MediaAlertDialog();
      },
    );
    if (data == 'yes') {
      if (mounted) context.read<MediaCubit>().deleteMultiMedia();
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;

    return BlocListener<MediaCubit, MediaState>(
      listenWhen: (previous, current) => previous.deleting != current.deleting,
      listener: (context, state) {
        if (state.deleting == 'complete') {
          showSuccess(context, translate('message:text_delete_media_success'));
        }
        if (state.deleting == 'error') {
          showError(context, translate('message:text_delete_media_fail'));
        }
      },
      child: BlocBuilder<MediaCubit, MediaState>(
        builder: (context, state) {
          if (!state.isSelect) {
            return Container(
              height: 95,
              alignment: AlignmentDirectional.topEnd,
              padding: const EdgeInsetsDirectional.only(end: 25, top: 15),
              child: ProductListButtonAdd(
                onPressed: () => _pickImage(),
              ),
            );
          }
          if (state.mediaSelected.isEmpty) {
            return Container(height: 0);
          }
          return MediaListBottom(
            title: Text(translate('media:text_count_select', {'count': '${state.mediaSelected.length}'}),
                style: theme.textTheme.bodyText2),
            action: InkResponse(
              onTap: () => _delete(context),
              child: state.deleting == 'pending'
                  ? buildLoading(radius: 12)
                  : Icon(
                      CommunityMaterialIcons.delete,
                      color: theme.textTheme.caption?.color,
                    ),
            ),
          );
        },
      ),
    );
  }
}
