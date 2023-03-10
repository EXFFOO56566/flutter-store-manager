// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enquiry_reply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnquiryReplyData _$EnquiryReplyDataFromJson(Map<String, dynamic> json) => EnquiryReplyData(
      id: json['ID'] as String?,
      enquiry: json['enquiry'] as String?,
      customerName: json['customer_name'] as String?,
      customerEmail: json['customer_email'] as String?,
      replyBy: json['reply_by'] as String?,
      date: json['posted'] as String?,
      count: json['reply_count'] as int?,
      data: EnquiryReplyData._fromValueData(json['all_replies']),
    );

DataReply _$DataReplyFromJson(Map<String, dynamic> json) => DataReply(
      id: json['ID'] as String?,
      reply: json['reply'] as String?,
      replyImage: json['reply_by_image'] as String?,
      replyName: json['reply_by_name'] as String?,
      date: json['posted'] as String?,
    );

Map<String, dynamic> _$EnquiryReplyDataToJson(EnquiryReplyData instance) => <String, dynamic>{
      'ID': instance.id,
      'enquiry': instance.enquiry,
      'customer_name': instance.customerName,
      'customer_email': instance.customerEmail,
      'reply_by': instance.replyBy,
      'posted': instance.date,
      'reply_count': instance.count,
      'all_replies': EnquiryReplyData._toValueData(instance.data),
    };

Map<String, dynamic> _$DataReplyToJson(DataReply instance) => <String, dynamic>{
      'ID': instance.id,
      'reply': instance.reply,
      'reply_by_image': instance.replyImage,
      'reply_by_name': instance.replyName,
      'posted': instance.date,
    };
