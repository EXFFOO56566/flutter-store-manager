// Flutter library
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:flutter/material.dart';

// Repository packages
import 'package:review_repository/review_repository.dart';

// View
import 'package:flutter_store_manager/themes.dart';

// Constants
import 'package:flutter_store_manager/constants/color_block.dart';

class ReviewRatingItem extends StatelessWidget with ReviewMixin {
  final Review? review;

  const ReviewRatingItem({
    Key? key,
    this.review,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String text = '${review?.reviewRating ?? '0.0'}';
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
      isLoading: review?.id is! String,
    );
  }
}
