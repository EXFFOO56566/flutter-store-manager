part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState(
      {required this.status,
      required this.token,
      required this.user,
      required this.isNewVendor,
      this.skipMultiStep = false});

  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user = User.empty,
    this.token = '',
    this.isNewVendor = false,
    this.skipMultiStep = false,
  });
  AuthenticationState copyWith({
    User? user,
    bool? skipMultiStep,
    AuthenticationStatus? status,
  }) {
    return AuthenticationState(
      status: status ?? this.status,
      token: token,
      user: user ?? this.user,
      isNewVendor: isNewVendor,
      skipMultiStep: skipMultiStep ?? this.skipMultiStep,
    );
  }

  const AuthenticationState.unknown() : this._();

  AuthenticationState.authenticated(Map<String, dynamic> response)
      : this._(
          status: AuthenticationStatus.authenticated,
          user: User.fromJson(response['user']),
          token: response['token'],
          isNewVendor: response['isNewVendor'] ?? false,
        );

  const AuthenticationState.unauthenticated() : this._(status: AuthenticationStatus.unauthenticated, token: '');
  final AuthenticationStatus status;
  final User user;
  final String token;
  final bool isNewVendor;
  final bool skipMultiStep;

  @override
  List<Object> get props => [status, token, user, skipMultiStep];

  factory AuthenticationState.fromJson(Map<String, dynamic> json) {
    return AuthenticationState(
      status: AuthenticationStatus.authenticated,
      token: json['token'],
      user: User.fromJson(json['user']),
      isNewVendor: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'token': token, 'user': user.toJson()};
  }
}
