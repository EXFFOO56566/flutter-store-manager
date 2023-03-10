import 'package:flutter/material.dart';
import 'package:ui/constants/constants.dart';

class ChatListContent extends StatelessWidget {
  final Widget searchWidget;
  final Widget recentWidget;
  final Widget viewWidget;
  final EdgeInsetsGeometry? paddingView;
  const ChatListContent({
    Key? key,
    required this.searchWidget,
    required this.recentWidget,
    required this.viewWidget,
    this.paddingView,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        searchWidget,
        const SizedBox(height: 30),
        recentWidget,
        const SizedBox(height: 30),
        Expanded(
          child: Container(
            height: double.infinity,
            padding: paddingView,
            width: double.infinity,
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: borderRadiusBottomSheetLarge,
            ),
            child: viewWidget,
          ),
        ),
      ],
    );
  }
}
