import 'package:bloc/bloc.dart';
import 'package:example/blocs/blocs.dart';
import 'package:example/mocks/mocks.dart';
import 'package:example/models/models.dart';

part 'review_list_state.dart';

class ReviewListCubit extends Cubit<ReviewListState> {
  final perPage = 10;

  ReviewListCubit() : super(const ReviewListState(reviews: []));

  Future<void> getReviews() async {
    try {
      emit(state.copyWith(
        actionState: const LoadingState(),
      ));
      await _getReviews(page: 1);
    } catch (_) {}
  }

  Future<void> refresh() async {
    await _getReviews(page: 1);
  }

  Future<void> loadMore() async {
    await _getReviews(page: state.page + 1);
  }

  Future<void> _getReviews({int page = 1}) async {
    try {
      final data = await getReviewApi(page: page, perPage: perPage);

      List<ReviewModel> reviewResponse = <ReviewModel>[];
      reviewResponse = data.map((review) => ReviewModel.fromJson(review)).toList().cast<ReviewModel>();
      var newReview = state.reviews;
      if (page == 1) {
        newReview = reviewResponse;
      } else {
        newReview.addAll(reviewResponse);
      }
      emit(
        state.copyWith(
          actionState: LoadedState(data: newReview.length),
          reviews: newReview,
          page: page,
        ),
      );
    } catch (e) {
      emit(state.copyWith(actionState: ErrorState(data: e.toString())));
      rethrow;
    }
  }

  bool get canLoadMore => state.reviews.length >= (state.page * perPage);
}
