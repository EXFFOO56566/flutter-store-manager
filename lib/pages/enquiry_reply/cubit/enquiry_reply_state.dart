part of 'enquiry_reply_cubit.dart';

class EnquiryReplyState extends BaseState {
  final EnquiryReplyData? data;
  final BaseState actionState;
  final BaseState replyState;
  final double? progress;
  final String? reply;

  const EnquiryReplyState({
    this.data,
    this.actionState = const InitState(),
    this.replyState = const InitState(),
    this.progress = 0.0,
    this.reply = '',
  });

  @override
  List<Object?> get props => [
        data,
        actionState,
        replyState,
        progress,
        reply,
      ];
  EnquiryReplyState copyWith({
    EnquiryReplyData? data,
    BaseState? actionState,
    BaseState? replyState,
    double? progress,
    String? reply,
  }) {
    return EnquiryReplyState(
      data: data ?? this.data,
      actionState: actionState ?? this.actionState,
      replyState: replyState ?? this.replyState,
      progress: progress ?? this.progress,
      reply: reply ?? this.reply,
    );
  }
}

class EnquiryReplyInitial extends EnquiryReplyState {}
