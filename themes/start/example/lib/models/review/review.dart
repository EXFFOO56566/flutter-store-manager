import 'package:json_annotation/json_annotation.dart';
import 'package:example/utils/utils.dart';

part 'review.g.dart';

@JsonSerializable()
class ReviewModel {
  @JsonKey(name: 'ID')
  String? id;

  @JsonKey(name: 'vendor_id')
  String? vendorId;

  @JsonKey(name: 'author_id')
  String? authorId;

  @JsonKey(name: 'author_name')
  String? authorName;

  @JsonKey(name: 'author_email')
  String? authorEmail;

  @JsonKey(name: 'review_title')
  String? reviewTitle;

  @JsonKey(name: 'review_description')
  String? reviewDescription;

  @JsonKey(name: 'review_rating', fromJson: toDouble)
  double? reviewRating;

  @JsonKey(fromJson: fromJsonApprove, toJson: toJsonApprove)
  bool? approved;

  String? created;

  @JsonKey(name: 'author_image')
  String? authorImage;

  ReviewModel({
    this.id,
    this.vendorId,
    this.authorId,
    this.authorName,
    this.authorEmail,
    this.reviewTitle,
    this.reviewDescription,
    this.reviewRating,
    this.approved,
    this.created,
    this.authorImage,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) => _$ReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);

  static double toDouble(dynamic json) {
    return ConvertData.stringToDouble(json);
  }

  static bool fromJsonApprove(dynamic value) {
    return value == '1';
  }

  static String toJsonApprove(dynamic value) {
    return value == true ? '1' : '0';
  }
}
