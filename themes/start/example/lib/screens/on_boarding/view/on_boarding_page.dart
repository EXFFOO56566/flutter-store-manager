import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/ui.dart';

import 'package:example/blocs/blocs.dart';

List _data = [
  {
    'image': 'assets/images/getting-1.png',
    'title': 'Store Manager',
    'subtitle': 'Now have total control over your stores and manager them with ease.',
  },
  {
    'image': 'assets/images/getting-2.png',
    'title': 'Simplified Dashboard',
    'subtitle': 'This app makes it easy for vendors to manage their products,',
  },
  {
    'image': 'assets/images/getting-3.png',
    'title': 'Real Time Reporting',
    'subtitle': 'Keeping track of sales with real-time notifications',
  }
];

class OnBoardingPage extends StatelessWidget {
  static const routeName = '/on-boarding';

  const OnBoardingPage({Key? key}) : super(key: key);

  void onApp(BuildContext context) {
    context.read<SettingCubit>().closeOnBoarding();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double widthItem = mediaQuery.size.width - 74;

    return Scaffold(
      body: OnBoardingContainer(
        count: _data.length,
        itemBuilder: (_, int index) {
          dynamic item = _data[index];
          return Padding(
            padding: const EdgeInsets.fromLTRB(37, 118, 37, 0),
            child: OnBoardingItem(
              image: Image.asset(
                item['image'],
                width: widthItem,
              ),
              title: item['title'],
              subtitle: item['subtitle'],
            ),
          );
        },
        buttonControlBuilder: (_, int activeIndex, VoidCallback nextAction) {
          if (activeIndex == _data.length - 1) {
            return ElevatedButton(
              onPressed: () => onApp(context),
              child: const Text('Get Start'),
            );
          }
          return ElevatedButton(
            onPressed: nextAction,
            child: const Text('Next'),
          );
        },
        skip: TextButton(
          onPressed: () => onApp(context),
          style: TextButton.styleFrom(
            foregroundColor: theme.textTheme.subtitle1?.color, padding: EdgeInsets.zero,
            minimumSize: const Size(0, 0),
            textStyle: theme.textTheme.bodyText2,
          ),
          child: const Text('Skip'),
        ),
      ),
    );
  }
}
