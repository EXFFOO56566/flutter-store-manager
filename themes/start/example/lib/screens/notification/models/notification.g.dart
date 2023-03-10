// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationList _$NotificationListFromJson(Map<String, dynamic> json) => NotificationList(
      id: json['ID'] as String?,
      message: json['message'] as String?,
      messageType: json['message_type'] as String?,
      created: json['created'] as String?,
    );

Map<String, dynamic> _$NotificationListToJson(NotificationList instance) => <String, dynamic>{
      'ID': instance.id,
      'message': instance.message,
      'message_type': instance.messageType,
      'created': instance.created,
    };
