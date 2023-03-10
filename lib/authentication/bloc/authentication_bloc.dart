import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc extends HydratedBloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        // _userRepository = userRepository,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    on<SkipMultiStep>(_onSkipMultiStep);
    on<AvatarChanged>(_avatarChanged);
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  // final UserRepository _userRepository;
  late StreamSubscription<Map<String, dynamic>> _authenticationStatusSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  void _onSkipMultiStep(
    SkipMultiStep event,
    Emitter<AuthenticationState> emit,
  ) {
    emit(state.copyWith(skipMultiStep: true));
  }

  void _avatarChanged(
    AvatarChanged event,
    Emitter<AuthenticationState> emit,
  ) {
    emit(state.copyWith(status: AuthenticationStatus.unknown));
    emit(AuthenticationState.authenticated({
      'token': state.token,
      'user': {...state.user.toJson(), 'avatar': event.avatar},
    }));
  }

  void _onAuthenticationStatusChanged(
    AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    if (event.response['token'] != null && event.response['token'] != '') {
      emit(AuthenticationState.authenticated(event.response));
    } else if (event.response['token'] == null) {
      emit(const AuthenticationState.unauthenticated());
    } else {
      emit(const AuthenticationState.unknown());
    }
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    _authenticationRepository.logOut();
  }

  @override
  AuthenticationState fromJson(Map<String, dynamic> json) {
    if (json['token'] != null && json['token'] != '') {
      return AuthenticationState.fromJson(json);
    }
    return const AuthenticationState.unauthenticated();
  }

  @override
  Map<String, dynamic> toJson(AuthenticationState state) {
    return state.toJson();
  }
}
