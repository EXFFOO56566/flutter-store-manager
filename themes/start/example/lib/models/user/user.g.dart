// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['ID'] as int?,
      userLogin: json['user_login'] as String?,
      userEmail: json['user_email'] as String?,
      dateRegistered: json['user_registered'] as String?,
      fullName: json['display_name'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'ID': instance.id,
      'user_login': instance.userLogin,
      'user_email': instance.userEmail,
      'user_registered': instance.dateRegistered,
      'display_name': instance.fullName,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'avatar': instance.avatar,
    };
