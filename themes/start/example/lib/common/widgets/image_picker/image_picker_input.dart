// Flutter library
import 'dart:io';
import 'package:example/common/model/image_data.dart';
import 'package:example/common/model/image_file.dart';
import 'package:example/string_generate.dart';
import 'package:example/utils/debug.dart';
import 'package:flutter/cupertino.dart';

// Packages and Dependencies
import 'package:image_picker/image_picker.dart';

import 'package:ui/ui.dart';

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
  State<ImagePickerInput> createState() => _ImagePickerInputState();
}

class _ImagePickerInputState extends State<ImagePickerInput> {
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

  Future<void> _pickImage(BuildContext context) async {
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
              if (!mounted) return;
              Navigator.pop(context);
            } catch (e) {
              avoidPrint('error $e');
            }
          },
          child: const Text("Take a Photo"),
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

              if (!mounted) return;
              Navigator.pop(context);
            } catch (e) {
              avoidPrint('error $e');
            }
          },
          child: const Text("Photo Library"),
        ),
        CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () async {},
          child: const Text("Library From Server"),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Text("Cancel"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
    showCupertinoModalPopup(context: context, builder: (context) => action);
  }

  @override
  Widget build(BuildContext context) {
    return UploadImage(
      title: widget.label,
      image: _buildPreview(widget.value),
      titleButton: "Sellect Image",
      clickButton: () => _pickImage(context),
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
