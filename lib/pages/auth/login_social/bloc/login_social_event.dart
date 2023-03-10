part of 'login_social_bloc.dart';

abstract class LoginSocialEvent extends Equatable {
  const LoginSocialEvent();
  @override
  List<Object> get props => [];
}

class LoginSocialSubmitted extends LoginSocialEvent {
  final Map<String, dynamic> queryParameters;

  const LoginSocialSubmitted(this.queryParameters);

  @override
  List<Object> get props => [queryParameters];
}
