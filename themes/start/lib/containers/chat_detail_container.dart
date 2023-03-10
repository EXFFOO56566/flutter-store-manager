import 'package:flutter/material.dart';
import 'package:ui/mixins/mixins.dart';
import 'package:ui/constants/constants.dart';

class ChatDetailContainer extends StatelessWidget with AppbarMixin {
  final Widget appBar;
  final Widget messages;

  const ChatDetailContainer({
    Key? key,
    required this.appBar,
    required this.messages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        leading: leading(),
        title: appBar,
        toolbarHeight: 90,
        elevation: 0,
        leadingWidth: 68,
        backgroundColor: Colors.transparent,
        titleSpacing: 0,
      ),
      body: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: const BoxDecoration(borderRadius: borderRadiusBottomSheetLarge),
        child: messages,
      ),
    );
  }
}
