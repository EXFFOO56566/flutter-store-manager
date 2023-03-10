// Flutter library
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_manager/pages/media/media.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:flutter_store_manager/types/types.dart';

// Packages and Dependencies
import 'package:image_picker/image_picker.dart';
import 'package:media_repository/media_repository.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Models
import '../model/image_data.dart';
import '../model/image_file.dart';
import '../model/image_link.dart';

class ImagePickerInput extends StatefulWidget {
  final String? label;
  final void Function(ImageData) onChanged;
  final void Function() onDeleted;
  final ImageData? value;

  const ImagePickerInput({
    Key? key,
    this.label,
    this.value,
    required this.onChanged,
    required this.onDeleted,
  }) : super(key: key);

  @override
  ImagePickerInputState createState() => ImagePickerInputState();
}

class ImagePickerInputState extends State<ImagePickerInput> {
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  void _onChanged(XFile xFile) {
    ImageFile file = ImageFile(id: StringGenerate.uuid(), path: xFile.path);
    ImageData imageData = ImageData(type: ImageDataType.file, file: file);
    widget.onChanged(imageData);
  }

  Future<void> _pickImage(BuildContext context, TranslateType translate) async {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
    final action = CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () async {
            try {
              XFile? xFile = await _picker.pickImage(
                source: ImageSource.camera,
                imageQuality: 50,
                maxWidth: 600,
              );
              if (xFile != null) {
                _onChanged(xFile);
              }
              if (mounted) {
                Navigator.pop(context);
              }
            } catch (e) {
              avoidPrint('error $e');
            }
          },
          child: Text(translate('common:text_take_photo')),
        ),
        CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () async {
            try {
              XFile? xFile = await _picker.pickImage(
                source: ImageSource.gallery,
                imageQuality: 50,
                maxWidth: 600,
              );

              if (xFile != null) {
                _onChanged(xFile);
              }
              if (mounted) {
                Navigator.pop(context);
              }
            } catch (e) {
              avoidPrint('error $e');
            }
          },
          child: Text(translate('common:text_photo_library')),
        ),
        CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () async {
            try {
              dynamic data = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return MediaLibraryPage(
                      isMulti: false,
                      onChanged: (image) {
                        Navigator.pop(context, image);
                      },
                    );
                  },
                  fullscreenDialog: true,
                ),
              );
              if (data is List && data.isNotEmpty) {
                Media item = data[0];
                ImageLink imageLink = ImageLink.fromJson({
                  'id': item.id,
                  'src': item.url,
                });
                ImageData imageData = ImageData(type: ImageDataType.image, image: imageLink);
                widget.onChanged(imageData);
                if (mounted) Navigator.pop(context);
              }
            } catch (e) {
              avoidPrint('error $e');
            }
          },
          child: Text(translate('common:text_photo_library_server')),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text(translate('common:text_cancel')),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
    showCupertinoModalPopup(context: context, builder: (context) => action);
  }

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;

    return UploadImage(
      title: widget.label,
      image: _buildPreview(widget.value),
      titleButton: translate('common:text_select_image'),
      clickButton: () => _pickImage(context, translate),
    );
  }

  Widget _buildPreview(ImageData? imageData) {
    late Widget image;

    if (imageData?.type == ImageDataType.file && imageData?.file != null) {
      image = Image.file(
        File(imageData!.file!.path),
        width: 80,
        height: 80,
        fit: BoxFit.cover,
      );
    } else if (imageData?.type == ImageDataType.image && imageData?.image != null) {
      image = CacheImageView(image: imageData?.image?.src ?? '', width: 80, height: 80);
    } else {
      image = const CacheImageView(image: '', width: 80, height: 80);
    }

    Widget viewImage = ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: image,
    );

    if (imageData != null) {
      return ImageUploadItem(
        image: viewImage,
        onRemove: widget.onDeleted,
      );
    }

    return viewImage;
  }
}
