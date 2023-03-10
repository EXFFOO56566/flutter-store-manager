// Packages & Dependencies or Helper function
import 'package:json_annotation/json_annotation.dart';

part 'enquiry.g.dart';

@JsonSerializable(createToJson: false)
class Enquiry {
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

  Enquiry({
    this.id,
    this.enquiry,
    this.customerName,
    this.customerEmail,
    this.replyBy,
  });

  factory Enquiry.fromJson(Map<String, dynamic> json) => _$EnquiryFromJson(json);
}
