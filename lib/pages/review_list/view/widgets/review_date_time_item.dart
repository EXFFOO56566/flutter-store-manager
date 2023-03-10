// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Repository packages
import 'package:review_repository/review_repository.dart';

// View
import 'package:flutter_store_manager/themes.dart';

class ReviewDateTimeItem extends StatelessWidget with ReviewMixin {
  final Review? review;

  const ReviewDateTimeItem({
    Key? key,
    this.review,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return buildDateTime(
      date: formatDate(date: review?.created ?? DateTime.now().toString(), dateFormat: 'dd/MM/yyyy'),
      time: formatDate(date: review?.created ?? DateTime.now().toString(), dateFormat: 'hh:mm a'),
      theme: theme,
      isLoading: review?.id is! String,
    );
  }
}
