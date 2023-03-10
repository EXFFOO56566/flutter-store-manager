import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;

  final String userLogin;

  final String userNiceName;

  final String userEmail;

  final String displayName;

  final String firstName;

  final String lastName;

  final String avatar;

  final String socialAvatar;

  final String loginType;

  final List<String> roles;

  const User({
    required this.id,
    required this.userLogin,
    required this.userNiceName,
    required this.userEmail,
    required this.displayName,
    required this.firstName,
    required this.lastName,
    required this.avatar,
    required this.socialAvatar,
    required this.loginType,
    required this.roles,
  });

  static const User empty = User(
    id: '',
    avatar: '',
    displayName: '',
    firstName: '',
    lastName: '',
    loginType: '',
    socialAvatar: '',
    userEmail: '',
    userLogin: '',
    userNiceName: '',
    roles: [],
  );

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object> get props => [id, userLogin, roles];
}

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['ID'] as String,
      userLogin: json['user_login'] ?? '',
      userNiceName: json['user_nicename'] ?? '',
      userEmail: json['user_email'] ?? '',
      displayName: json['display_name'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      avatar: json['avatar'] ?? 'https://cdn.rnlab.io/placeholder-416x416.png',
      socialAvatar: json['socialAvatar'] ?? '',
      loginType: json['loginType'] ?? '' ?? 'email',
      roles: (json['roles'] as List<dynamic>?)!.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'ID': instance.id,
      'user_login': instance.userLogin,
      'user_nicename': instance.userNiceName,
      'user_email': instance.userEmail,
      'display_name': instance.displayName,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'avatar': instance.avatar,
      'socialAvatar': instance.socialAvatar,
      'loginType': instance.loginType,
      'roles': instance.roles,
    };
