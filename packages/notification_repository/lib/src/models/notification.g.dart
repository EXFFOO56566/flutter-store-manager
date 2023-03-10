// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationData _$NotificationDataFromJson(Map<String, dynamic> json) => NotificationData(
      id: json['ID'] as String?,
      message: json['message'] as String?,
      messageType: json['message_type'] as String?,
      created: json['created'] as String?,
    );

Map<String, dynamic> _$NotificationDataToJson(NotificationData instance) => <String, dynamic>{
      'ID': instance.id,
      'message': instance.message,
      'message_type': instance.messageType,
      'created': instance.created,
    };

CountNotificationData _$CountNotificationDataFromJson(Map<String, dynamic> json) => CountNotificationData(
      notice: json['notice'] as int?,
      message: json['message'] as String?,
      enquiry: json['enquiry'] as String?,
    );

Map<String, dynamic> _$CountNotificationDataToJson(CountNotificationData instance) => <String, dynamic>{
      'notice': instance.notice,
      'message': instance.message,
      'enquiry': instance.enquiry,
    };
