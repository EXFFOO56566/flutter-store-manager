// App core
import 'package:appcheap_flutter_core/utils/convert_data.dart';

// Packages & Dependencies or Helper function
import 'package:json_annotation/json_annotation.dart';

part 'review.g.dart';

@JsonSerializable()
class Review {
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

  String? approved;

  String? created;

  @JsonKey(name: 'author_image')
  String? authorImage;

  Review({
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

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);

  static double? toDouble(dynamic json) {
    return ConvertData.stringToDouble(json);
  }
}
