// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Packages & Dependencies or Helper function
import 'package:bloc/bloc.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';

// Repository packages
import 'package:review_repository/review_repository.dart';

part 'review_detail_state.dart';

class ReviewDetailCubit extends Cubit<ReviewDetailState> {
  final ReviewRepository reviewRepository;
  final String token;
  final RequestCancel _cancelToken = RequestCancel();

  ReviewDetailCubit({
    required this.reviewRepository,
    required this.token,
  }) : super(ReviewDetailState(review: Review()));

  Future<void> initReview({required Review? review}) async {
    if (review != null) {
      emit(state.copyWith(
        review: review,
        approved: (review.approved == "1") ? true : false,
      ));
    }
  }

  Future<void> approveReview({required bool approve}) async {
    emit(state.copyWith(buttonState: const LoadingState()));
    try {
      await _approveReview(approve: approve);
    } catch (_) {}
  }

  Future<void> _approveReview({required bool approve}) async {
    Map<String, dynamic> body = {};
    if (approve) {
      body = {"review_status": "approve"};
    } else {
      body = {"review_status": "unapprove"};
    }
    try {
      await reviewRepository.approveReview(
          id: state.review?.id ?? '',
          requestData: RequestData(
            query: {'app-builder-decode': true},
            token: token,
            data: body,
            responseType: 'plain',
            cancelToken: _cancelToken,
          ));
      emit(
        state.copyWith(
          buttonState: const LoadedState(),
          changeStatus: true,
          approved: !state.approved,
        ),
      );
    } on RequestError catch (e) {
      emit(state.copyWith(buttonState: ErrorState(data: e.message)));
      rethrow;
    }
  }

  @override
  Future<void> close() {
    _cancelToken.cancel();
    return super.close();
  }
}
