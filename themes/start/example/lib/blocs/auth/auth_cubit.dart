import 'package:example/models/models.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends HydratedCubit<AuthState> {
  AuthCubit() : super(AuthState(user: UserModel()));

  void loginAuth(UserModel user) {
    emit(state.copyWith(user: user, isLogin: true));
  }

  void logoutAuth() {
    emit(state.copyWith(user: UserModel(), isLogin: false));
  }

  @override
  AuthState fromJson(Map<String, dynamic> json) {
    return AuthState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state.toJson();
  }
}
