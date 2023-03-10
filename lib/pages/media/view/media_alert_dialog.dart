import 'package:flutter/cupertino.dart';

import '../../../types/types.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

class MediaAlertDialog extends StatelessWidget {
  const MediaAlertDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    return CupertinoAlertDialog(
      title: Text(translate('media:text_please_confirm')),
      content: Text(translate('media:text_remove')),
      actions: [
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(context).pop('yes');
          },
          isDefaultAction: true,
          isDestructiveAction: true,
          child: Text(translate('media:text_yes')),
        ),
        CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(),
          isDefaultAction: false,
          isDestructiveAction: false,
          child: Text(translate('media:text_no')),
        )
      ],
    );
  }
}
