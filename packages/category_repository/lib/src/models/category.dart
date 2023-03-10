// Packages & Dependencies or Helper function
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  int? id;
  String? name;
  int? parent;
  List<Category>? categories;
  Map<String, dynamic>? image;
  int? count;

  Category({
    this.id,
    this.name,
    this.parent,
    this.categories,
    this.image,
    this.count,
  });

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
