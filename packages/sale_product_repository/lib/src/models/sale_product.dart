// Packages & Dependencies or Helper function
import 'package:json_annotation/json_annotation.dart';

part 'sale_product.g.dart';

@JsonSerializable(createToJson: false)
class SaleProduct {
  SaleProduct({required this.count, this.name});

  final int count;
  final String? name;

  factory SaleProduct.fromJson(Map<String, dynamic> json) => _$SaleProductFromJson(json);
}
