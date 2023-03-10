part of 'auth_cubit.dart';

class AuthState {
  final bool isLogin;
  final UserModel user;

  const AuthState({
    required this.user,
    this.isLogin = false,
  });

  List<Object?> get props => [user, false];

  AuthState copyWith({
    UserModel? user,
    bool? isLogin,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLogin: isLogin ?? this.isLogin,
    );
  }

  factory AuthState.fromJson(Map<String, dynamic> json) => _$AuthStateFromJson(json);

  Map<String, dynamic> toJson() => _$AuthStateToJson(this);
}

AuthState _$AuthStateFromJson(Map<String, dynamic> json) => AuthState(
      user: UserModel.fromJson((json['user'] ?? {}) as Map<String, dynamic>),
      isLogin: (json['isLogin'] ?? false) as bool,
    );

Map<String, dynamic> _$AuthStateToJson(AuthState instance) => <String, dynamic>{
      'user': instance.user.toJson(),
      'isLogin': instance.isLogin,
    };
