import 'package:flutter/material.dart';
import 'package:example/models/models.dart';
import 'package:example/utils/utils.dart';
import 'package:ui/ui.dart';

class ReviewDateTimeItem extends StatelessWidget with ReviewMixin {
  final ReviewModel? reviewModel;

  const ReviewDateTimeItem({
    Key? key,
    this.reviewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return buildDateTime(
      date: formatDate(date: reviewModel?.created ?? DateTime.now().toString(), dateFormat: 'dd/MM/yyyy'),
      time: formatDate(date: reviewModel?.created ?? DateTime.now().toString(), dateFormat: 'hh:mm a'),
      theme: theme,
      isLoading: reviewModel?.id is! String,
    );
  }
}
