// Packages & Dependencies or Helper function
import 'package:json_annotation/json_annotation.dart';

part 'order_note.g.dart';

@JsonSerializable()
class OrderNote {
  int? id;
  @JsonKey(name: "added_by")
  String? addedBy;

  @JsonKey(name: "customer_note")
  bool? customerNote;

  @JsonKey(name: 'date_created')
  Map<String, dynamic>? dateCreated;

  String? content;
  OrderNote({
    this.id,
    this.dateCreated,
    this.addedBy,
    this.content,
    this.customerNote,
  });

  factory OrderNote.fromJson(Map<String, dynamic> json) => _$OrderNoteFromJson(json);

  Map<String, dynamic> toJson() => _$OrderNoteToJson(this);
}
