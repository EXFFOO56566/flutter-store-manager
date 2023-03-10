import 'package:replay_bloc/replay_bloc.dart';

part 'chat_state.dart';

class ChatCubit extends ReplayCubit<ChatState> {
  ChatCubit() : super(const ChatState());

  void changeKeyword({String? keyword}) {
    emit(state.copyWith(
      keyword: keyword,
    ));
  }
}

List<Map<String, dynamic>> getSearchContact({List<Map<String, dynamic>> data = const [], String search = ''}) {
  if (search.isEmpty) {
    return data;
  }
  return data.where((element) {
    dynamic name = element['user_name'];
    if (name is String) {
      return name.toLowerCase().contains(search.toLowerCase());
    }
    return false;
  }).toList();
}
