// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';
import 'package:flutter_store_manager/pages/review_list/view/widgets/review_date_time_item.dart';
import 'package:flutter_store_manager/pages/review_list/view/widgets/review_rating_item.dart';
import 'package:flutter_store_manager/types/types.dart';

// Repository packages
import 'package:review_repository/review_repository.dart';

// Bloc
import '../../bloc/review_detail_cubit.dart';

//Themes
import 'package:flutter_store_manager/themes.dart';

// Constants
import 'package:flutter_store_manager/constants/color_block.dart';

class ReviewDetailBody extends StatefulWidget {
  final Review? review;
  const ReviewDetailBody({Key? key, required this.review}) : super(key: key);

  @override
  ReviewDetailBodyState createState() => ReviewDetailBodyState();
}

class ReviewDetailBodyState extends State<ReviewDetailBody> with ReviewMixin, LoadingMixin {
  late ReviewDetailCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<ReviewDetailCubit>();
    cubit.initReview(review: widget.review);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;
    return BlocBuilder<ReviewDetailCubit, ReviewDetailState>(
      builder: (_, state) {
        Review? data = state.review;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              iconSize: 22,
              onPressed: () => Navigator.pop(context, state.changeStatus),
            ),
            title: Text(
              AppLocalizations.of(context)!.translate('account:text_detail_review'),
            ),
            leadingWidth: 68,
          ),
          body: ReviewDetailContainer(
            content: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(25, 10, 25, 25),
              child: ReviewDetailContent(
                avatar: buildAvatar(url: data?.authorImage),
                name: buildName(name: data?.authorName, theme: theme),
                dateTime: ReviewDateTimeItem(review: data),
                rating: ReviewRatingItem(review: data),
                description: Text(
                  (data?.reviewDescription != null) ? data!.reviewDescription!.unescape : "",
                  style: theme.textTheme.caption,
                ),
              ),
            ),
            buttonBottom: BlocConsumer<ReviewDetailCubit, ReviewDetailState>(
              builder: (context, state) {
                return Center(
                  child: SizedBox(
                    width: 196,
                    child: ElevatedButton(
                      onPressed: () {
                        if (state.buttonState is! LoadingState) {
                          if (!state.approved) {
                            cubit.approveReview(approve: true);
                          } else {
                            cubit.approveReview(approve: false);
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor: (!state.approved == true) ? ColorBlock.blue : ColorBlock.red),
                      child: state.buttonState is LoadingState
                          ? buildLoadingElevated()
                          : Text((!state.approved == true)
                              ? translate('account:text_button_approve_review')
                              : translate('account:text_button_unapprove_review')),
                    ),
                  ),
                );
              },
              listener: (context, state) {
                if (state.buttonState is LoadedState) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(translate('common:text_success'))));
                } else if (state.buttonState is ErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(translate('common:text_failure'))));
                }
              },
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }
}
