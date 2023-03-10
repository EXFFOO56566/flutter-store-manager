import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable()
class NotificationList {
  @JsonKey(name: 'ID')
  String? id;

  String? message;

  @JsonKey(name: 'message_type')
  String? messageType;

  String? created;

  NotificationList({
    this.id,
    this.message,
    this.messageType,
    this.created,
  });

  factory NotificationList.fromJson(Map<String, dynamic> json) => _$NotificationListFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationListToJson(this);
}
