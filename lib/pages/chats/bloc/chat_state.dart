part of 'chat_cubit.dart';

class ChatState {
  final String? keyword;
  const ChatState({this.keyword = ''});

  List<Object?> get props => [keyword];

  ChatState copyWith({String? keyword}) {
    return ChatState(
      keyword: keyword ?? this.keyword,
    );
  }
}
