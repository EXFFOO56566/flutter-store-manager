import 'package:community_material_icon/community_material_icon.dart';
import 'package:example/blocs/blocs.dart';
import 'package:example/models/models.dart';
import 'package:example/screens/screens.dart';
import 'package:example/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/ui.dart';

import '../cubit/review_list_cubit.dart';
import '../widgets/widgets.dart';

class ReviewListBody extends StatefulWidget {
  const ReviewListBody({Key? key}) : super(key: key);

  @override
  State<ReviewListBody> createState() => _ReviewListBody();
}

class _ReviewListBody extends State<ReviewListBody> {
  late ReviewListCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ReviewListCubit>();
    _cubit.getReviews();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future _loadMore() async {
    await _cubit.loadMore();
  }

  Future _refresh() async {
    await _cubit.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewListCubit, ReviewListState>(
      builder: (context, state) {
        final canLoadMore = _cubit.canLoadMore;
        return state.actionState is! LoadingState && state.reviews.isEmpty
            ? const NotificationEmptyView(
                icon: CommunityMaterialIcons.star_circle,
                title: 'Empty Reviews',
              )
            : BaseSmartFresher(
                onRefresh: _refresh,
                onLoadMore: canLoadMore ? _loadMore : null,
                child: _body(state, context),
              );
      },
    );
  }

  Widget _body(ReviewListState state, BuildContext context) {
    List<ReviewModel> emptyReview = List.generate(_cubit.perPage, (index) => ReviewModel()).toList();
    List<ReviewModel> date = state.actionState is LoadingState ? emptyReview : state.reviews;

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
      itemCount: date.length,
      itemBuilder: (context, index) {
        final item = date[index];
        return ReviewItem(
          reviewModel: item,
          padding: const EdgeInsets.symmetric(vertical: 18),
          onTap: () {
            if (item.id?.isNotEmpty == true) {
              Navigator.of(context).pushNamed(ReviewDetailPage.routeName, arguments: item).then((value) {});
            }
          },
        );
      },
    );
  }
}
