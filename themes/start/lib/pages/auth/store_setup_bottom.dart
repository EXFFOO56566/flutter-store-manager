import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui/constants/constants.dart';
import 'package:ui/widgets/elevated_color_button.dart';

class StoreSetupBottom extends StatelessWidget {
  final String textButtonPrimary;
  final String textButtonSecondary;
  final VoidCallback onPressedPrimary;
  final VoidCallback onPressedSecondary;
  final EdgeInsetsGeometry? padding;
  final bool loading;

  const StoreSetupBottom({
    Key? key,
    required this.textButtonPrimary,
    required this.textButtonSecondary,
    required this.onPressedPrimary,
    required this.onPressedSecondary,
    this.padding,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      padding: padding,
      decoration: BoxDecoration(color: theme.cardColor, boxShadow: initShadow),
      child: Row(
        children: [
          Expanded(
            child: ElevatedColorButton.surface(
              onPressed: onPressedSecondary,
              minimumSize: const Size(0, 41),
              padding: EdgeInsets.zero,
              textStyle: theme.textTheme.button?.copyWith(fontSize: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Text(textButtonSecondary),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: ElevatedButton(
              onPressed: onPressedPrimary,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(0, 41),
                padding: EdgeInsets.zero,
                textStyle: theme.textTheme.button?.copyWith(fontSize: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: (!loading) ? Text(textButtonPrimary) : const CupertinoActivityIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
