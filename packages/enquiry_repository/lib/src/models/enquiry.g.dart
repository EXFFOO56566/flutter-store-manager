// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enquiry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Enquiry _$EnquiryFromJson(Map<String, dynamic> json) => Enquiry(
      id: json['ID'] as String?,
      enquiry: json['enquiry'] as String?,
      customerName: json['customer_name'] as String?,
      customerEmail: json['customer_email'] as String?,
      replyBy: json['reply_by'] as String?,
    )..date = json['posted'] as String?;
