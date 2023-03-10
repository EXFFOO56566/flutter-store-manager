// Packages & Dependencies or Helper function
import 'package:json_annotation/json_annotation.dart';

part "personal.g.dart";

@JsonSerializable()
class Personal {
  String? avatar;

  @JsonKey(name: 'avatar_src')
  String? avatarSrc;

  String? email;

  @JsonKey(name: 'first_name')
  String? firstName;

  @JsonKey(name: 'last_name')
  String? lastName;

  String? phone;

  String? description;

  Personal({
    this.avatar,
    this.avatarSrc,
    this.email,
    this.firstName,
    this.lastName,
    this.phone,
    this.description,
  });

  factory Personal.fromJson(Map<String, dynamic> json) => _$PersonalFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalToJson(this);
}

@JsonSerializable()
class Socials {
  String? twitter;

  String? fb;

  String? instagram;

  String? youtube;

  String? linkedin;

  String? snapchat;

  String? gplus;

  String? googleplus;

  String? facebook;

  String? pinterest;

  Socials({
    this.twitter,
    this.fb,
    this.instagram,
    this.youtube,
    this.linkedin,
    this.snapchat,
    this.gplus,
    this.googleplus,
    this.facebook,
    this.pinterest,
  });

  factory Socials.fromJson(Map<String, dynamic> json) => _$SocialsFromJson(json);

  Map<String, dynamic> toJson() => _$SocialsToJson(this);
}
