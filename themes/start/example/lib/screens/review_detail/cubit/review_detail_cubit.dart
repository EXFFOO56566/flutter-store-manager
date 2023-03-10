import 'package:bloc/bloc.dart';
import 'package:example/blocs/blocs.dart';
import 'package:example/mocks/mocks.dart';
import 'package:example/models/models.dart';

part 'review_detail_state.dart';

class ReviewDetailCubit extends Cubit<ReviewDetailState> {
  ReviewDetailCubit({required ReviewModel data}) : super(ReviewDetailState(data: data));

  Future<void> onApprove() async {
    try {
      emit(state.copyWith(
        actionState: const LoadingState(),
      ));
      await _onApprove();
    } catch (_) {}
  }

  Future<void> _onApprove() async {
    try {
      Map<String, dynamic> data = await approveReviewApi(id: state.data.id ?? '');
      ReviewModel review = ReviewModel.fromJson(data);
      emit(
        state.copyWith(actionState: LoadedState(data: review.id), data: review),
      );
    } catch (e) {
      emit(state.copyWith(actionState: ErrorState(data: e.toString())));
      rethrow;
    }
  }
}
