import 'package:appcheap_flutter_core/utils/utils.dart';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:flutter_store_manager/types/types.dart';

class SuccessStep extends StatelessWidget with AppbarMixin {
  final VoidCallback onComplete;

  const SuccessStep({
    Key? key,
    required this.onComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;

    return Scaffold(
      appBar: AppBar(
        leading: leading(onPressed: onComplete),
        title: Text(translate('delete_account:text_txt')),
        shadowColor: Colors.transparent,
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          // child: Column(
          //   children: [
          //     Text(
          //       translate('delete_account:text_success_title'),
          //       textAlign: TextAlign.center,
          //       style: Theme.of(context).textTheme.headline6,
          //     ),
          //     Text(
          //       translate('delete_account:text_success_subtitle'),
          //       textAlign: TextAlign.center,
          //       style: Theme.of(context).textTheme.bodyText2,
          //     ),
          //     ElevatedButton(
          //       onPressed: onComplete,
          //       style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 16)),
          //       child: Text(translate('delete_account:text_success_button')),
          //     )
          //   ],
          // ),
          child: NotificationEmptyView.button(
            icon: FontAwesomeIcons.userTimes,
            titleWidget: Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                translate('delete_account:text_success_title'),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            contentWidget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                translate('delete_account:text_success_subtitle'),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            styleBtn: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 16)),
            textButton: Text(translate('delete_account:text_success_button')),
            onPressed: onComplete,
          ),
        ),
      ),
    );
  }
}
