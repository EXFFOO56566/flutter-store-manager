import 'package:flutter/cupertino.dart';
import 'package:ui/ui.dart';

class SelectImage extends StatelessWidget {
  final String? label;
  const SelectImage({
    Key? key,
    this.label,
  }) : super(key: key);

  void _pickImage(BuildContext context) async {
    final action = CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () async {
            Navigator.pop(context);
          },
          child: const Text('Take Photo'),
        ),
        CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () async {
            Navigator.pop(context);
          },
          child: const Text('Photo Library'),
        )
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Text('Cancel'),
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
      image: const CacheImageView(image: '', width: 80, height: 80),
      clickButton: () => _pickImage(context),
      title: label,
    );
  }
}
