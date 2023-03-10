// Flutter library
import 'dart:io';
import 'package:example/common/model/image_data.dart';
import 'package:example/common/model/image_file.dart';
import 'package:example/string_generate.dart';
import 'package:example/utils/debug.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Packages and Dependencies
import 'package:image_picker/image_picker.dart';
import 'package:ui/ui.dart';

// Models

class ImagesPickerInput extends StatefulWidget {
  final String? label;
  final void Function(List<ImageData>) onChanged;
  final void Function(ImageData item) onDeleted;
  final List<ImageData>? value;
  final bool showIcon;

  const ImagesPickerInput({
    Key? key,
    this.label,
    this.value,
    required this.onChanged,
    required this.onDeleted,
    this.showIcon = false,
  }) : super(key: key);

  @override
  State<ImagesPickerInput> createState() => _ImagesPickerInputState();
}

class _ImagesPickerInputState extends State<ImagesPickerInput> {
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
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
                ImageFile file = ImageFile(id: StringGenerate.uuid(), path: xFile.path);
                ImageData imageData = ImageData(type: ImageDataType.file, file: file);
                widget.onChanged([imageData]);
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
              List<XFile>? xFiles = await _picker.pickMultiImage(
                imageQuality: 50,
                maxWidth: 600,
              );

              if (xFiles != null) {
                List<ImageData> images = <ImageData>[];
                images = xFiles
                    .map((xFile) {
                      ImageFile file = ImageFile(id: StringGenerate.uuid(), path: xFile.path);
                      return ImageData(type: ImageDataType.file, file: file);
                    })
                    .toList()
                    .cast<ImageData>();
                widget.onChanged(images);
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
    if (widget.showIcon) {
      return GestureDetector(
        onTap: () => _pickImage(
          context,
        ),
        child: const InputHtmlButtonToolbar(icon: Icons.camera_alt_outlined),
      );
    }
    return UploadGalleryImage(
      title: widget.label,
      images: widget.value?.isNotEmpty == true
          ? List.generate(
              widget.value!.length,
              (index) {
                ImageData item = widget.value![index];
                return ImageUploadItem(
                  image: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: _buildImage(imageData: item, size: 80),
                  ),
                  onRemove: () => widget.onDeleted(item),
                );
              },
            )
          : [],
      clickUpload: () => _pickImage(context),
    );
  }

  Widget _buildImage({
    ImageData? imageData,
    double size = 80,
  }) {
    if (imageData?.type == ImageDataType.file && imageData?.file != null) {
      return Image.file(File(imageData!.file!.path), width: size, height: size, fit: BoxFit.cover);
    }
    if (imageData?.type == ImageDataType.image && imageData?.image != null) {
      return CacheImageView(image: imageData?.image?.src ?? '', width: size, height: size);
    }
    return CacheImageView(image: '', width: size, height: size);
  }
}
