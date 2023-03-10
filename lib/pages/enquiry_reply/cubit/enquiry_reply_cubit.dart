import 'package:appcheap_flutter_core/di/di.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:enquiry_repository/enquiry_repository.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';

part 'enquiry_reply_state.dart';

class EnquiryReplyCubit extends Cubit<EnquiryReplyState> {
  final EnquiryRepository enquiryRepository;
  final String token;

  EnquiryReplyCubit({
    required this.enquiryRepository,
    required this.token,
  }) : super(EnquiryReplyInitial());

  Future<void> getEnquiryDetail({required int id}) async {
    emit(state.copyWith(
      actionState: const LoadingState(),
    ));
    await _getEnquiryDetail(id);
  }

  Future<void> updateReply({required int id, required String reply}) async {
    emit(state.copyWith(
      reply: reply,
      progress: 0.0,
      replyState: const LoadingState(),
    ));
    await _updateReply(id, reply);
  }

  Future<void> _getEnquiryDetail(int id) async {
    try {
      Map<String, dynamic> queryParameters = {
        'app-builder-decode': true,
      };
      EnquiryReplyData enquiryReplies = await enquiryRepository.getEnquiryDetail(
        id: id,
        requestData: RequestData(
          token: token,
          query: queryParameters,
        ),
      );
      emit(state.copyWith(
        data: enquiryReplies,
        actionState: const LoadedState(),
      ));
    } on DioError catch (e) {
      if (e.type != DioErrorType.cancel) {
        emit(state.copyWith(actionState: ErrorState(data: e.toString())));
      }
    }
  }

  Future<void> _updateReply(int id, String reply) async {
    double progress = 0.0;
    try {
      EnquiryReplyData enquiryReplies = await enquiryRepository.updateReply(
        id: id,
        requestData: RequestData(
          token: token,
          data: {'enquiry_reply': reply},
          query: {'app-builder-decode': true},
          onReceiveProgress: (int sent, int total) {
            progress = sent / total * 100;
            emit(state.copyWith(
              progress: progress,
            ));
          },
        ),
      );
      emit(state.copyWith(
        data: enquiryReplies,
        replyState: const LoadedState(),
      ));
    } on RequestError catch (e) {
      emit(state.copyWith(replyState: ErrorState(data: e.message)));
    }
  }
}
