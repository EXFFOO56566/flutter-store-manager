import 'package:flutter/material.dart';
import 'package:example/models/models.dart';
import 'package:example/utils/utils.dart';
import 'package:example/constants/color_block.dart';
import 'package:ui/ui.dart';

class ReviewRatingItem extends StatelessWidget with ReviewMixin {
  final ReviewModel? reviewModel;

  const ReviewRatingItem({
    Key? key,
    this.reviewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String text = '${reviewModel?.reviewRating ?? '0.0'}';
    double num = ConvertData.stringToDouble(text, 0);
    Color color = ColorBlock.redError;

    if (num >= 4) {
      color = ColorBlock.green;
    } else if (num >= 2) {
      color = ColorBlock.orange;
    }
    return buildRating(
      rating: text,
      color: color,
      isLoading: reviewModel?.id is! String,
    );
  }
}
