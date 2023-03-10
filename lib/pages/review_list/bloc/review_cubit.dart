// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Packages & Dependencies or Helper function
import 'package:bloc/bloc.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';

// Repository packages
import 'package:review_repository/review_repository.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final pageSize = 10;
  final ReviewRepository reviewRepository;
  final RequestCancel _cancelToken = RequestCancel();

  final String token;
  ReviewCubit({required this.reviewRepository, required this.token}) : super(const ReviewState(reviews: []));

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
      List<Review> data = await reviewRepository.getReview(
        requestData: RequestData(
          query: {
            'page': page,
            'per_page': pageSize,
            'app-builder-decode': true,
          },
          token: token,
          cancelToken: _cancelToken,
        ),
      );
      var newReview = state.reviews;
      if (page == 1) {
        newReview = data;
      } else {
        newReview.addAll(data);
      }
      emit(
        state.copyWith(
          actionState: LoadedState(data: newReview.length),
          reviews: newReview,
          page: page,
        ),
      );
    } on RequestError catch (e) {
      if (e.type == RequestErrorType.cancel) {
        emit(state.copyWith(actionState: ErrorState(data: e.message)));
      }
    }
  }

  bool get canLoadMore => state.reviews.length >= (state.page * pageSize);

  @override
  Future<void> close() {
    _cancelToken.cancel();
    return super.close();
  }
}
