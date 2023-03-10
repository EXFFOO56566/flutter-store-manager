// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';
import 'package:flutter_store_manager/common/widgets/base_smart_fresher.dart';

// Repository packages
import 'package:review_repository/review_repository.dart';

// Bloc
import '../../bloc/review_cubit.dart';

// View
import 'package:flutter_store_manager/pages/review_detail/review_detail.dart';
import 'package:flutter_store_manager/themes.dart';
import 'review_item.dart';

class ReviewsBody extends StatefulWidget {
  const ReviewsBody({Key? key}) : super(key: key);

  @override
  ReviewsBodyState createState() => ReviewsBodyState();
}

class ReviewsBodyState extends State<ReviewsBody> {
  late ReviewCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<ReviewCubit>();
    cubit.getReviews();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewCubit, ReviewState>(
      builder: (context, state) {
        final canLoadMore = cubit.canLoadMore;
        return state.actionState is! LoadingState && state.reviews.isEmpty
            ? NotificationEmptyView(
                icon: CommunityMaterialIcons.star_circle,
                title: AppLocalizations.of(context)!.translate('account:text_review_empty'),
              )
            : BaseSmartFresher(
                onRefresh: _refresh,
                onLoadMore: canLoadMore ? _loadMore : null,
                child: _body(state, context),
              );
      },
    );
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  Widget _body(ReviewState state, BuildContext context) {
    List<Review> emptyReview = List.generate(10, (index) => Review()).toList();
    List<Review> date = state.actionState is LoadingState ? emptyReview : state.reviews;

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
      itemCount: date.length,
      itemBuilder: (context, index) {
        final item = date[index];
        return ReviewItem(
          review: item,
          padding: const EdgeInsets.symmetric(vertical: 18),
          onTap: () {
            Navigator.of(context).pushNamed(ReviewDetailPage.routeName, arguments: item).then((value) {
              if (value == true) {
                cubit.getReviews();
              }
            });
          },
        );
      },
    );
  }

  Future _loadMore() async {
    await cubit.loadMore();
  }

  Future _refresh() async {
    await cubit.refresh();
  }
}
