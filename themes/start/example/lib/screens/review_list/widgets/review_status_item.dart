import 'package:flutter/material.dart';
import 'package:example/models/models.dart';
import 'package:ui/ui.dart';

class ReviewStatusItem extends StatelessWidget with ReviewMixin {
  final ReviewModel? reviewModel;

  const ReviewStatusItem({
    Key? key,
    this.reviewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    String textStatus = reviewModel?.approved == true ? 'Approved' : 'Un-approved';

    return buildStatus(
      status: textStatus,
      theme: theme,
      isLoading: reviewModel?.id is! String,
    );
  }
}
