part of 'review_detail_cubit.dart';

class ReviewDetailState extends BaseState {
  final Review? review;
  final BaseState actionState;
  final BaseState buttonState;
  final bool approved;
  final bool changeStatus;
  const ReviewDetailState({
    this.review,
    this.actionState = const InitState(),
    this.buttonState = const InitState(),
    this.approved = false,
    this.changeStatus = false,
  });

  @override
  List<Object?> get props => [review, buttonState, actionState, approved, changeStatus];

  ReviewDetailState copyWith({
    Review? review,
    BaseState? actionState,
    BaseState? buttonState,
    bool? approved,
    bool? changeStatus,
  }) {
    return ReviewDetailState(
      review: review ?? this.review,
      actionState: actionState ?? this.actionState,
      buttonState: buttonState ?? this.buttonState,
      approved: approved ?? this.approved,
      changeStatus: changeStatus ?? this.changeStatus,
    );
  }
}
