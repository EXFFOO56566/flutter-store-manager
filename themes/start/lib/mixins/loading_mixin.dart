import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingMixin {
  Widget buildLoading({double radius = 14, Color? color}) {
    return CupertinoActivityIndicator(
      radius: radius,
      color: color,
    );
  }

  Widget buildLoadingElevated({double radius = 10}) {
    return Builder(
      builder: (BuildContext context) {
        ThemeData theme = Theme.of(context);
        return CupertinoActivityIndicator(
          radius: radius,
          color: theme.colorScheme.onPrimary,
        );
      },
    );
  }

  Widget buildLoadingElevatedSurface({double radius = 10}) {
    return Builder(
      builder: (BuildContext context) {
        ThemeData theme = Theme.of(context);
        return CupertinoActivityIndicator(
          radius: radius,
          color: theme.textTheme.subtitle1?.color,
        );
      },
    );
  }
}
