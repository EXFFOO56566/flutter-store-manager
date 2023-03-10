import 'package:replay_bloc/replay_bloc.dart';

class TabsCubit extends ReplayCubit<int> {
  TabsCubit() : super(0);

  void onItemTapped(int index) {
    if (state != index) emit(index);
  }
}
