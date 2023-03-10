import 'package:flutter/material.dart';
import 'package:ui/widgets/smart_fresher.dart';

class BaseSmartFresher extends StatelessWidget {
  final Widget child;
  final Future Function()? onRefresh;
  final Future Function()? onLoadMore;

  const BaseSmartFresher({
    Key? key,
    required this.child,
    this.onRefresh,
    this.onLoadMore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmartFresher(
      onLoadMore: onLoadMore,
      onRefresh: onRefresh,
      textLoadingFooter: 'Loading...',
      child: child,
    );
  }
}
