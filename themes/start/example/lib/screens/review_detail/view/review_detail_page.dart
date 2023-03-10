import 'package:community_material_icon/community_material_icon.dart';
import 'package:example/models/models.dart';
import 'package:example/screens/review_list/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/ui.dart';

import '../cubit/review_detail_cubit.dart';
import '../widgets/button_approve.dart';

class ReviewDetailPage extends StatelessWidget with AppbarMixin, ReviewMixin {
  static const routeName = '/review-detail';

  const ReviewDetailPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic data = ModalRoute.of(context)!.settings.arguments;

    Widget body = data is ReviewModel && data.id?.isNotEmpty == true
        ? _ReviewDetailData(data: data)
        : const NotificationEmptyView(
            icon: CommunityMaterialIcons.star_circle,
            title: 'No data',
          );

    return Scaffold(
      appBar: baseStyleAppBar(title: 'Detail Review'),
      body: body,
    );
  }
}

class _ReviewDetailData extends StatelessWidget with ReviewMixin {
  final ReviewModel data;

  const _ReviewDetailData({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocProvider(
      create: (context) {
        return ReviewDetailCubit(data: data);
      },
      child: BlocBuilder<ReviewDetailCubit, ReviewDetailState>(
        buildWhen: (previous, current) => previous.data != current.data,
        builder: (_, state) {
          ReviewModel review = state.data;
          return ReviewDetailContainer(
            content: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(25, 10, 25, 25),
              child: ReviewDetailContent(
                avatar: buildAvatar(url: review.authorImage ?? ''),
                name: buildName(name: review.authorName ?? '', theme: theme),
                dateTime: ReviewDateTimeItem(reviewModel: review),
                rating: ReviewRatingItem(reviewModel: review),
                description: Text(
                  review.reviewDescription ?? '',
                  style: theme.textTheme.caption,
                ),
              ),
            ),
            buttonBottom: const Center(
              child: SizedBox(
                width: 196,
                child: ButtonApprove(),
              ),
            ),
          );
        },
      ),
    );
  }
}
