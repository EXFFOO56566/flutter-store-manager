// Packages & Dependencies or Helper function
import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable()
class NotificationData {
  @JsonKey(name: 'ID')
  String? id;

  String? message;

  @JsonKey(name: 'message_type')
  String? messageType;

  String? created;

  NotificationData({
    this.id,
    this.message,
    this.messageType,
    this.created,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) => _$NotificationDataFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationDataToJson(this);
}

class CountNotificationData {
  int? notice;

  String? message;

  String? enquiry;

  CountNotificationData({
    this.notice,
    this.message,
    this.enquiry,
  });

  factory CountNotificationData.fromJson(Map<String, dynamic> json) => _$CountNotificationDataFromJson(json);
  Map<String, dynamic> toJson() => _$CountNotificationDataToJson(this);
}
