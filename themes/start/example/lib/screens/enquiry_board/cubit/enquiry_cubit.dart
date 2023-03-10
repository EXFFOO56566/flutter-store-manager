import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:example/blocs/blocs.dart';
import 'package:example/mocks/enquiry_board_mock.dart';

import '../models/enquiry_board.dart';

part 'enquiry_state.dart';

class EnquiryBoardCubit extends Cubit<EnquiryBoardState> {
  final perPage = 10;
  EnquiryBoardCubit() : super(EnquiryBoardInitial());
  Future<void> getEnquiryBoard() async {
    try {
      emit(state.copyWith(
        actionState: const LoadingState(),
      ));
      await _getEnquiryBoard(page: 1);
    } catch (_) {}
  }

  Future<void> refresh() async {
    await _getEnquiryBoard(page: 1);
  }

  Future<void> loadMore() async {
    await _getEnquiryBoard(page: state.page + 1);
  }

  Future<void> _getEnquiryBoard({int page = 1}) async {
    try {
      final data = await getEnquiryBoardListApi(page: page, perPage: perPage);
      List<EnquiryBoard> enquiryBoardResponse = <EnquiryBoard>[];
      enquiryBoardResponse =
          data.map((enquiryBoard) => EnquiryBoard.fromJson(enquiryBoard)).toList().cast<EnquiryBoard>();
      var newEnquiryBoard = state.enquiryBoard;
      if (page == 1) {
        newEnquiryBoard = enquiryBoardResponse;
      } else {
        newEnquiryBoard.addAll(enquiryBoardResponse);
      }
      emit(
        state.copyWith(
          actionState: LoadedState(data: newEnquiryBoard.length),
          enquiryBoard: newEnquiryBoard,
          page: page,
        ),
      );
    } catch (e) {
      emit(state.copyWith(actionState: ErrorState(data: e.toString())));
      rethrow;
    }
  }

  bool get canLoadMore => state.enquiryBoard.length >= (state.page * perPage);
}
