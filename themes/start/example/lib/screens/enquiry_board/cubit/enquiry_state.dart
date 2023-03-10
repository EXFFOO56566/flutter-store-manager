part of 'enquiry_cubit.dart';

class EnquiryBoardState extends Equatable {
  final List<EnquiryBoard> enquiryBoard;
  final BaseState actionState;
  final int page;
  const EnquiryBoardState({
    this.enquiryBoard = const [],
    this.actionState = const InitState(),
    this.page = 0,
  });

  @override
  List<Object> get props => [
        enquiryBoard,
        actionState,
        page,
      ];
  EnquiryBoardState copyWith({
    List<EnquiryBoard>? enquiryBoard,
    BaseState? actionState,
    int? page,
  }) {
    return EnquiryBoardState(
      enquiryBoard: enquiryBoard ?? this.enquiryBoard,
      actionState: actionState ?? this.actionState,
      page: page ?? this.page,
    );
  }
}

class EnquiryBoardInitial extends EnquiryBoardState {}
