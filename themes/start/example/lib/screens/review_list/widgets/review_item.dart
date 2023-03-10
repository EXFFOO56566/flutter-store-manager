import 'package:flutter/material.dart';
import 'package:example/models/models.dart';
import 'package:ui/ui.dart';

import 'review_rating_item.dart';
import 'review_date_time_item.dart';
import 'review_status_item.dart';

class ReviewItem extends StatelessWidget with ReviewMixin {
  final EdgeInsetsGeometry? padding;
  final double? indentDivider;
  final double? endIndentDivider;
  final ReviewModel? reviewModel;
  final GestureTapCallback? onTap;

  const ReviewItem({
    Key? key,
    this.padding,
    this.indentDivider,
    this.endIndentDivider,
    this.reviewModel,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    bool loading = reviewModel?.id is! String;

    return ReviewItemUi(
      avatar: buildAvatar(url: reviewModel?.authorImage, isLoading: loading),
      name: buildName(theme: theme, name: reviewModel?.authorName, isLoading: loading),
      status: ReviewStatusItem(reviewModel: reviewModel),
      dateTime: ReviewDateTimeItem(reviewModel: reviewModel),
      description: buildDescription(theme: theme, description: reviewModel?.reviewDescription, isLoading: loading),
      rating: ReviewRatingItem(reviewModel: reviewModel),
      padding: padding,
      indentDivider: indentDivider ?? 80,
      endIndentDivider: endIndentDivider,
      dividerColor: theme.dividerColor,
      onTap: onTap,
    );
  }
}
