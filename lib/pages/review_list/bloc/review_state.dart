part of 'review_cubit.dart';

class ReviewState extends BaseState {
  final List<Review> reviews;
  final BaseState actionState;
  final int page;
  const ReviewState({
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

  ReviewState copyWith({
    List<Review>? reviews,
    BaseState? actionState,
    int? page,
  }) {
    return ReviewState(
      reviews: reviews ?? this.reviews,
      actionState: actionState ?? this.actionState,
      page: page ?? this.page,
    );
  }
}
