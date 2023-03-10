import 'package:replay_bloc/replay_bloc.dart';

class TabBarCubit extends ReplayCubit<int> {
  TabBarCubit() : super(0);

  void onItemTapped(int index) {
    if (state != index) emit(index);
  }
}
