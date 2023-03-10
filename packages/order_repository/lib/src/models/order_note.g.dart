// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderNote _$OrderNoteFromJson(Map<String, dynamic> json) => OrderNote(
      id: json['id'] as int?,
      dateCreated: json['date_created'] as Map<String, dynamic>?,
      addedBy: json['added_by'] as String?,
      content: json['content'] as String?,
      customerNote: json['customer_note'] as bool?,
    );

Map<String, dynamic> _$OrderNoteToJson(OrderNote instance) => <String, dynamic>{
      'id': instance.id,
      'added_by': instance.addedBy,
      'content': instance.content,
      'customer_note': instance.customerNote,
      'date_created': instance.dateCreated,
    };
