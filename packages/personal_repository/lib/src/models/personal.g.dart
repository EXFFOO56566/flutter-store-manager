// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Personal _$PersonalFromJson(Map<String, dynamic> json) => Personal(
      avatar: json['avatar'] as String?,
      avatarSrc: json['avatar_src'] as String?,
      email: json['email'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      phone: json['phone'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$PersonalToJson(Personal instance) => <String, dynamic>{
      'avatar': instance.avatar,
      'avatar_src': instance.avatarSrc,
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'phone': instance.phone,
      'description': instance.description,
    };

Socials _$SocialsFromJson(Map<String, dynamic> json) => Socials(
      twitter: json['twitter'] as String?,
      fb: json['fb'] as String?,
      instagram: json['instagram'] as String?,
      youtube: json['youtube'] as String?,
      linkedin: json['linkedin'] as String?,
      snapchat: json['snapchat'] as String?,
      gplus: json['gplus'] as String?,
      googleplus: json['googleplus'] as String?,
      facebook: json['facebook'] as String?,
      pinterest: json['pinterest'] as String?,
    );

Map<String, dynamic> _$SocialsToJson(Socials instance) => <String, dynamic>{
      'twitter': instance.twitter,
      'fb': instance.fb,
      'instagram': instance.instagram,
      'youtube': instance.youtube,
      'linkedin': instance.linkedin,
      'snapchat': instance.snapchat,
      'gplus': instance.gplus,
      'googleplus': instance.googleplus,
      'facebook': instance.facebook,
      'pinterest': instance.pinterest,
    };
