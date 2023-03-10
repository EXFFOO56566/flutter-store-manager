import 'package:flutter/material.dart';
import 'package:ui/widgets/elevated_color_button.dart';
import 'package:ui/widgets/label_input.dart';

class UploadImage extends StatelessWidget {
  final Widget image;
  final String? title;
  final String? titleButton;
  final VoidCallback? clickButton;

  const UploadImage({
    Key? key,
    required this.image,
    this.title,
    this.titleButton,
    this.clickButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title?.isNotEmpty == true)
          LabelInput(
            title: title ?? '',
            padding: const EdgeInsets.only(bottom: 6),
          ),
        SizedBox(
          width: double.infinity,
          child: Wrap(
            spacing: 20,
            runSpacing: 12,
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: [
              image,
              ElevatedColorButton.surface(
                onPressed: clickButton,
                minimumSize: const Size(0, 41),
                textStyle: theme.textTheme.button?.copyWith(fontSize: 14),
                padding: const EdgeInsets.symmetric(horizontal: 38),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Text(titleButton ?? 'Select Image'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
