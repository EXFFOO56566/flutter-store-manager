// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OptionAttribute _$OptionAttributeFromJson(Map<String, dynamic> json) => OptionAttribute(
      termId: json['term_id'] as int?,
      taxonomy: json['taxonomy'] as String?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      count: json['count'] as int?,
      value: OptionAttribute._fromValue(json['value']),
    );

Attribute _$AttributeFromJson(Map<String, dynamic> json) => Attribute(
      id: json['id'] as int?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      type: json['type'] as String?,
      hasArchives: json['has_archives'] as bool?,
      options: json['options'] == null ? null : AttributeOptionAttributes.fromJson(json['options'] as List<dynamic>),
    )..terms = json['terms'] == null ? null : AttributeOptionAttributes.fromJson(json['terms'] as List<dynamic>);
