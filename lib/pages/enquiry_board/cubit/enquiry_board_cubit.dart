import 'package:appcheap_flutter_core/di/di.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:enquiry_repository/enquiry_repository.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';

part 'enquiry_board_state.dart';

class EnquiryBoardCubit extends Cubit<EnquiryBoardState> {
  final EnquiryRepository enquiryRepository;
  final String token;
  final pageSize = 10;
  EnquiryBoardCubit({
    required this.enquiryRepository,
    required this.token,
  }) : super(EnquiryBoardInitial());

  Future<void> getEnquiry() async {
    emit(state.copyWith(
      actionState: const LoadingState(),
    ));
    await _getEnquiry(page: 1);
  }

  Future<void> refresh() async {
    await _getEnquiry(page: 1);
  }

  Future<void> loadMore() async {
    await _getEnquiry(page: state.page + 1);
  }

  Future<void> _getEnquiry({int page = 1}) async {
    try {
      Map<String, dynamic> queryParameters = {
        'page': page,
        'per_page': pageSize,
        'app-builder-decode': true,
      };
      List<Enquiry> enquiryBoard = await enquiryRepository.getEnquiry(
        requestData: RequestData(
          token: token,
          query: queryParameters,
        ),
      );
      var newEnquiryBoard = state.enquiryBoard;
      if (page == 1) {
        newEnquiryBoard = enquiryBoard;
      } else {
        newEnquiryBoard.addAll(enquiryBoard);
      }
      emit(state.copyWith(
        enquiryBoard: newEnquiryBoard,
        actionState: LoadedState(data: newEnquiryBoard.length),
        page: page,
      ));
    } on DioError catch (e) {
      if (e.type != DioErrorType.cancel) {
        emit(state.copyWith(actionState: ErrorState(data: e.toString())));
      }
    }
  }

  bool get canLoadMore => state.enquiryBoard.length >= (state.page * pageSize);

  @override
  Future<void> close() {
    return super.close();
  }
}
