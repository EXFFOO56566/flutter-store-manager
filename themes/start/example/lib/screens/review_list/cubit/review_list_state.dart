part of 'review_list_cubit.dart';

class ReviewListState extends BaseState {
  final List<ReviewModel> reviews;
  final BaseState actionState;
  final int page;

  const ReviewListState({
    this.reviews = const [],
    this.actionState = const InitState(),
    this.page = 0,
  });

  @override
  List<Object?> get props => [
        reviews,
        page,
        actionState,
      ];

  ReviewListState copyWith({
    List<ReviewModel>? reviews,
    BaseState? actionState,
    int? page,
  }) {
    return ReviewListState(
      reviews: reviews ?? this.reviews,
      actionState: actionState ?? this.actionState,
      page: page ?? this.page,
    );
  }
}
