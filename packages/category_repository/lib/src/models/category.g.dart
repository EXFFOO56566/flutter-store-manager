// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      id: json['id'] as int?,
      name: json['name'] as String?,
      parent: json['parent'] as int?,
      categories:
          (json['categories'] as List<dynamic>?)?.map((e) => Category.fromJson(e as Map<String, dynamic>)).toList(),
      image: json['image'] as Map<String, dynamic>?,
      count: json['count'] as int?,
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'parent': instance.parent,
      'categories': instance.categories,
      'image': instance.image,
      'count': instance.count,
    };
