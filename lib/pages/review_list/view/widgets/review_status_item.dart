// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter_store_manager/types/types.dart';

// Repository packages
import 'package:review_repository/review_repository.dart';

// View
import 'package:flutter_store_manager/themes.dart';

class ReviewStatusItem extends StatelessWidget with ReviewMixin {
  final Review? review;

  const ReviewStatusItem({
    Key? key,
    this.review,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;

    String textStatus = review?.approved == '1' ? translate('common:text_approve') : translate('common:text_unapprove');
    return buildStatus(
      status: textStatus,
      theme: theme,
      isLoading: review?.id is! String,
    );
  }
}
