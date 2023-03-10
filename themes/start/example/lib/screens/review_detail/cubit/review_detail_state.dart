part of 'review_detail_cubit.dart';

class ReviewDetailState extends BaseState {
  final ReviewModel data;
  final BaseState actionState;
  const ReviewDetailState({
    required this.data,
    this.actionState = const InitState(),
  });

  @override
  List<Object?> get props => [
        data,
        actionState,
      ];

  ReviewDetailState copyWith({
    ReviewModel? data,
    BaseState? actionState,
  }) {
    return ReviewDetailState(
      data: data ?? this.data,
      actionState: actionState ?? this.actionState,
    );
  }
}
