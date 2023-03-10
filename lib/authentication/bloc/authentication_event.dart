part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStatusChanged extends AuthenticationEvent {
  const AuthenticationStatusChanged(this.response);

  final Map<String, dynamic> response;

  @override
  List<Object> get props => [response];
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}

class SkipMultiStep extends AuthenticationEvent {}

class AvatarChanged extends AuthenticationEvent {
  const AvatarChanged(this.avatar);

  final String avatar;

  @override
  List<Object> get props => [avatar];
}
