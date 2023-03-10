import 'package:json_annotation/json_annotation.dart';
part 'enquiry_board.g.dart';

@JsonSerializable(createToJson: false)
class EnquiryBoard {
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

  EnquiryBoard({
    this.id,
    this.enquiry,
    this.customerName,
    this.customerEmail,
    this.replyBy,
  });

  factory EnquiryBoard.fromJson(Map<String, dynamic> json) => _$EnquiryBoardFromJson(json);
}
