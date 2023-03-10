import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../screens.dart';

class ReviewItem extends StatelessWidget with ReviewMixin {
  final EdgeInsetsGeometry? padding;
  final double? indentDivider;
  final double? endIndentDivider;

  const ReviewItem({
    Key? key,
    this.padding,
    this.indentDivider,
    this.endIndentDivider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return ReviewItemUi(
      avatar: buildAvatar(
          url:
              'https://static.vecteezy.com/packs/media/components/global/search-explore-nav/img/vectors/term-bg-1-666de2d941529c25aa511dc18d727160.jpg'),
      name: buildName(name: 'Tom Masey', theme: theme),
      status: buildStatus(status: 'Pending', theme: theme),
      dateTime: buildDateTime(date: '29/10/2019', time: '10:00 AM', theme: theme),
      description: buildDescription(description: 'Everything was just fine. Good Deal...', theme: theme),
      rating: buildRating(rating: '5.0', color: const Color(0xFF2BBD69)),
      padding: padding,
      indentDivider: indentDivider ?? 80,
      endIndentDivider: endIndentDivider,
      dividerColor: theme.dividerColor,
      onTap: () => Navigator.pushNamed(context, ReviewDetailScreen.routeName),
    );
  }
}
