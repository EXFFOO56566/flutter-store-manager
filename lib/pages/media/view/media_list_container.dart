import 'package:flutter/material.dart';
import 'package:flutter_store_manager/pages/media/media.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:flutter_store_manager/themes.dart';

import 'media_body_list.dart';
import 'media_button_select.dart';

class MediaListContainer extends StatelessWidget with AppbarMixin {
  final Widget bottom;
  final GetFromGalleryType? getFromGalleryType;
  const MediaListContainer({Key? key, required this.bottom, this.getFromGalleryType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    return Scaffold(
      appBar: baseStyleAppBar(title: translate('media:text_title'), actions: [
        MediaButtonSelect(onPressed: () {}),
        const SizedBox(width: 25),
      ]),
      extendBody: true,
      bottomNavigationBar: bottom,
      body: MediaBodyList(getFromGalleryType: getFromGalleryType),
    );
  }
}
