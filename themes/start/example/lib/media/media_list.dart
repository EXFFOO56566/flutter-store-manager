import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui/ui.dart';

import 'package:example/utils/utils.dart';

List<String> _images = [
  'https://upload.wikimedia.org/wikipedia/commons/9/9a/Gull_portrait_ca_usa.jpg',
  'https://static.remove.bg/remove-bg-web/b27c50a4d669fdc13528397ba4bc5bd61725e4cc/assets/start_remove-c851bdf8d3127a24e2d137a55b1b427378cd17385b01aec6e59d5d4b5f39d2ec.png',
  'https://interactive-examples.mdn.mozilla.net/media/cc0-images/grapefruit-slice-332-332.jpg',
  'https://www.w3schools.com/howto/img_forest.jpg',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvDbnh2bfELvkgZNlYP5Zp1Iu7IYG02pME6Q&usqp=CAU',
  'https://ps.w.org/tiny-compress-images/assets/icon-256x256.png?rev=1088385',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRyfxsDdRmIrdONoTLssEJouxfGBr_q9NMyg&usqp=CAU',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRY2YhMsJluE4eJFwPBIZu9k12vyBc7mRrnw&usqp=CAU',
  'https://www.perma-horti.com/wp-content/uploads/2019/02/image-2.jpg',
  'https://www.imgonline.com.ua/examples/bee-on-daisy.jpg',
  'https://images.ctfassets.net/hrltx12pl8hq/3j5RylRv1ZdswxcBaMi0y7/b84fa97296bd2350db6ea194c0dce7db/Music_Icon.jpg'
];

class MediaListScreen extends StatefulWidget {
  static const routeName = '/media_list';

  const MediaListScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MediaListScreen> createState() => _MediaListScreenState();
}

class _MediaListScreenState extends State<MediaListScreen> with AppbarMixin {
  late List<String> _data;
  late List<XFile> _dataLoading;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    _data = _images;
    _dataLoading = [];

    super.initState();
  }

  void _pickImage() async {
    final action = CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () async {
            try {
              await _picker.pickImage(
                source: ImageSource.camera,
                imageQuality: 50,
                maxWidth: 600,
              );
              if (!mounted) return;
              Navigator.pop(context);
            } catch (e) {
              avoidPrint("Err at pick img from camera");
            }
          },
          child: const Text('Take Photo'),
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
                setState(() {
                  _dataLoading.addAll(pickedFiles!);
                });
                if (!mounted) return;
                Navigator.pop(context);
                getLoading();
              }
            } catch (e) {
              avoidPrint("Err at pick img from photo library");
            }
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

  void getLoading() async {}
  @override
  Widget build(BuildContext context) {
    BorderRadius radius = BorderRadius.circular(8);

    return Scaffold(
      appBar: baseStyleAppBar(title: 'All Media'),
      extendBody: true,
      bottomNavigationBar: Container(
        alignment: AlignmentDirectional.bottomEnd,
        padding: const EdgeInsetsDirectional.only(bottom: 40, end: 25),
        child: ProductListButtonAdd(
          onPressed: () => _pickImage(),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.fromLTRB(25, 12, 25, 25),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300,
          childAspectRatio: 1,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: _data.length + _dataLoading.length,
        itemBuilder: (BuildContext ctx, index) {
          if (_dataLoading.isNotEmpty && index < _dataLoading.length) {
            return const Center(
              child: Text('Loading'),
            );
          } else {
            int visit = index - _dataLoading.length;
            String image = _data[visit];

            return ClipRRect(
              borderRadius: radius,
              child: CacheImageView(
                image: image,
                width: double.infinity,
                height: double.infinity,
              ),
            );
          }
        },
      ),
    );
  }
}
