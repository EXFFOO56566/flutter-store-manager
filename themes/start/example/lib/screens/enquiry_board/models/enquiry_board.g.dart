// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enquiry_board.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnquiryBoard _$EnquiryBoardFromJson(Map<String, dynamic> json) => EnquiryBoard(
      id: json['ID'] as String?,
      enquiry: json['enquiry'] as String?,
      customerName: json['customer_name'] as String?,
      customerEmail: json['customer_email'] as String?,
      replyBy: json['reply_by'] as String?,
    )..date = json['posted'] as String?;
