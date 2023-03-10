part of 'enquiry_board_cubit.dart';

class EnquiryBoardState extends BaseState {
  final List<Enquiry> enquiryBoard;
  final int page;
  final BaseState actionState;

  const EnquiryBoardState({
    this.enquiryBoard = const [],
    this.page = 1,
    this.actionState = const InitState(),
  });

  @override
  List<Object?> get props => [
        enquiryBoard,
        page,
        actionState,
      ];
  EnquiryBoardState copyWith({
    List<Enquiry>? enquiryBoard,
    int? page,
    BaseState? actionState,
  }) {
    return EnquiryBoardState(
      enquiryBoard: enquiryBoard ?? this.enquiryBoard,
      page: page ?? this.page,
      actionState: actionState ?? this.actionState,
    );
  }
}

class EnquiryBoardInitial extends EnquiryBoardState {}
