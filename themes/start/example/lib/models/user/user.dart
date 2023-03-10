import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: 'ID')
  int? id;

  @JsonKey(name: 'user_login')
  String? userLogin;

  @JsonKey(name: 'user_email')
  String? userEmail;

  @JsonKey(name: 'user_registered')
  String? dateRegistered;

  @JsonKey(name: 'display_name')
  String? fullName;

  @JsonKey(name: 'first_name')
  String? firstName;

  @JsonKey(name: 'last_name')
  String? lastName;

  String? avatar;

  UserModel({
    this.id,
    this.userLogin,
    this.userEmail,
    this.dateRegistered,
    this.fullName,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
