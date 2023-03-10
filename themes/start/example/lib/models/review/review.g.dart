// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel(
      id: json['ID'] as String?,
      vendorId: json['vendor_id'] as String?,
      authorId: json['author_id'] as String?,
      authorName: json['author_name'] as String?,
      authorEmail: json['author_email'] as String?,
      reviewTitle: json['review_title'] as String?,
      reviewDescription: json['review_description'] as String?,
      reviewRating: ReviewModel.toDouble(json['review_rating']),
      approved: ReviewModel.fromJsonApprove(json['approved']),
      created: json['created'] as String?,
      authorImage: json['author_image'] as String?,
    );

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) => <String, dynamic>{
      'ID': instance.id,
      'vendor_id': instance.vendorId,
      'author_id': instance.authorId,
      'author_name': instance.authorName,
      'author_email': instance.authorEmail,
      'review_title': instance.reviewTitle,
      'review_description': instance.reviewDescription,
      'review_rating': instance.reviewRating,
      'approved': ReviewModel.toJsonApprove(instance.approved),
      'created': instance.created,
      'author_image': instance.authorImage,
    };
