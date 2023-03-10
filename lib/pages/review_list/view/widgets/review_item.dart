// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Repository packages
import 'package:review_repository/review_repository.dart';

// View
import 'package:flutter_store_manager/themes.dart';
import 'review_rating_item.dart';
import 'review_date_time_item.dart';
import 'review_status_item.dart';

class ReviewItem extends StatelessWidget with ReviewMixin {
  final EdgeInsetsGeometry? padding;
  final double? indentDivider;
  final double? endIndentDivider;
  final Review? review;
  final GestureTapCallback? onTap;

  const ReviewItem({
    Key? key,
    this.padding,
    this.indentDivider,
    this.endIndentDivider,
    this.review,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    bool loading = review?.id is! String;

    return ReviewItemUi(
      avatar: buildAvatar(url: review?.authorImage, isLoading: loading),
      name: buildName(theme: theme, name: review?.authorName, isLoading: loading),
      status: ReviewStatusItem(review: review),
      dateTime: ReviewDateTimeItem(review: review),
      description: buildDescription(
          theme: theme,
          description: (review?.reviewDescription != null) ? review!.reviewDescription!.unescape : "",
          isLoading: loading),
      rating: ReviewRatingItem(review: review),
      padding: padding,
      indentDivider: indentDivider ?? 80,
      endIndentDivider: endIndentDivider,
      dividerColor: theme.dividerColor,
      onTap: onTap,
    );
  }
}
