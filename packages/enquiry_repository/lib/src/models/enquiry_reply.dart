// Packages & Dependencies or Helper function
import 'package:json_annotation/json_annotation.dart';

part 'enquiry_reply.g.dart';

@JsonSerializable(createToJson: false)
class EnquiryReplyData {
  @JsonKey(name: 'ID')
  String? id;

  String? enquiry;

  @JsonKey(name: 'customer_name')
  String? customerName;

  @JsonKey(name: 'customer_email')
  String? customerEmail;

  @JsonKey(name: 'reply_by')
  String? replyBy;

  @JsonKey(name: 'posted')
  String? date;

  @JsonKey(name: 'reply_count')
  int? count;

  @JsonKey(name: 'all_replies', fromJson: _fromValueData, toJson: _toValueData)
  List<DataReply>? data;

  EnquiryReplyData({
    this.id,
    this.enquiry,
    this.customerName,
    this.customerEmail,
    this.replyBy,
    this.date,
    this.count,
    this.data,
  });

  static List<DataReply>? _fromValueData(dynamic value) {
    if (value is List) {
      return value.map((e) => DataReply.fromJson(e)).toList().cast<DataReply>();
    }
    return null;
  }

  static dynamic _toValueData(List<DataReply>? value) {
    if (value is List) {
      return value!.map((e) => e.toJson()).toList();
    }
    return null;
  }

  factory EnquiryReplyData.fromJson(Map<String, dynamic> json) => _$EnquiryReplyDataFromJson(json);

  Map<String, dynamic> toJson() => _$EnquiryReplyDataToJson(this);
}

@JsonSerializable(createToJson: false)
class DataReply {
  @JsonKey(name: 'ID')
  String? id;

  String? reply;

  @JsonKey(name: 'reply_by_image')
  String? replyImage;

  @JsonKey(name: 'reply_by_name')
  String? replyName;

  @JsonKey(name: 'posted')
  String? date;

  DataReply({
    this.id,
    this.reply,
    this.replyImage,
    this.replyName,
    this.date,
  });

  factory DataReply.fromJson(Map<String, dynamic> json) => _$DataReplyFromJson(json);
  Map<String, dynamic> toJson() => _$DataReplyToJson(this);
}
