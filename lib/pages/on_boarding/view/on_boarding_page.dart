import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/constants/dimension.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:flutter_store_manager/themes.dart';

import 'package:flutter_store_manager/settings/settings.dart';

class OnBoardingPage extends StatelessWidget {
  static const routeName = '/on-boarding';

  const OnBoardingPage({Key? key}) : super(key: key);

  void onApp(BuildContext context) {
    context.read<SettingsCubit>().closeOnBoarding();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;
    MediaQueryData mediaQuery = MediaQuery.of(context);

    double widthItem = mediaQuery.size.width - 74;

    double topItem = height(context, 118);
    double topSkip = height(context, 64);
    double bottomPagination = height(context, 49);
    double spacingButtonPagination = height(context, 41);

    double padImage = height(context, 40);
    double padText = height(context, 9);

    final List data = [
      {
        'image': 'assets/images/boarding_1.png',
        'title': translate('getting_start:title_1'),
        'subtitle': translate('getting_start:description_1'),
      },
      {
        'image': 'assets/images/boarding_2.png',
        'title': translate('getting_start:title_2'),
        'subtitle': translate('getting_start:description_2'),
      },
      {
        'image': 'assets/images/boarding_3.png',
        'title': translate('getting_start:title_3'),
        'subtitle': translate('getting_start:description_3'),
      }
    ];

    return Scaffold(
      body: OnBoardingContainer(
        count: data.length,
        itemBuilder: (_, int index) {
          dynamic item = data[index];
          return Padding(
            padding: EdgeInsets.fromLTRB(37, topItem, 37, 0),
            child: OnBoardingItem(
              image: Image.asset(
                item['image'],
                width: widthItem,
              ),
              title: item['title'],
              subtitle: item['subtitle'],
              padImage: padImage,
              padText: padText,
            ),
          );
        },
        buttonControlBuilder: (_, int activeIndex, VoidCallback nextAction) {
          if (activeIndex == data.length - 1) {
            return ElevatedButton(
              onPressed: () => onApp(context),
              child: Text(translate('common:text_get_start')),
            );
          }
          return ElevatedButton(
            onPressed: nextAction,
            child: Text(translate('common:text_next')),
          );
        },
        skip: TextButton(
          onPressed: () => onApp(context),
          style: TextButton.styleFrom(
            foregroundColor: theme.textTheme.subtitle1?.color, padding: EdgeInsets.zero,
            minimumSize: const Size(0, 0),
            textStyle: theme.textTheme.bodyText2,
          ),
          child: Text(translate('common:text_skip')),
        ),
        topSkip: topSkip,
        bottomPagination: bottomPagination,
        spacingButtonPagination: spacingButtonPagination,
      ),
    );
  }
}
