import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';
// import 'package:flutter_store_manager/mixins/unescape_mixin.dart' show unescape;
import 'product_brand.dart';
import 'product_category.dart';
import 'product_price_format.dart';
import 'product_type.dart';

part 'product.g.dart';

@JsonSerializable(createToJson: false)
class Product {
  int? id;

  @JsonKey(fromJson: _toUnescape)
  String? name;

  String? slug;

  ProductTypeModel? type;

  String? status;

  @JsonKey(fromJson: _toUnescape)
  String? description;

  String? sku;

  @JsonKey(name: 'short_description', fromJson: _toUnescape)
  String? shortDescription;

  @JsonKey(fromJson: _fromJsonImage)
  List<Map<String, dynamic>>? images;

  List<ProductCategory?>? categories;

  @JsonKey(fromJson: _fromJson)
  String? price;

  @JsonKey(name: 'regular_price', fromJson: _fromJson)
  String? regularPrice;

  @JsonKey(name: 'sale_price', fromJson: _fromJson)
  String? salePrice;

  @JsonKey(name: 'on_sale')
  bool? onSale;

  @JsonKey(name: 'date_created')
  String? date;

  @JsonKey(name: 'average_rating')
  String? averageRating;

  @JsonKey(name: 'rating_count')
  int? ratingCount;

  @JsonKey(name: 'format_price')
  ProductPriceFormat? formatPrice;

  @JsonKey(name: 'catalog_visibility')
  String? catalogVisibility;

  @JsonKey(name: 'stock_status')
  String? stockStatus;

  @JsonKey(name: 'manage_stock')
  bool? manageStock;

  @JsonKey(name: 'stock_quantity', defaultValue: 0)
  int? stockQuantity;

  @JsonKey(name: 'related_ids')
  List<int>? relatedIds;

  @JsonKey(name: 'upsell_ids')
  List<int>? upsellIds;

  @JsonKey(name: 'grouped_products')
  List<int>? groupedIds;

  @JsonKey(name: 'external_url')
  String? externalUrl;

  @JsonKey(name: 'permalink')
  String? permalink;

  @JsonKey(name: 'button_text')
  String? buttonText;

  bool? purchasable;

  List<Map<String, dynamic>>? attributes;

  Map<String, dynamic>? store;

  @JsonKey(name: 'parent_id', defaultValue: 0)
  int? parentId;

  @JsonKey(name: 'meta_data')
  List<Map<String, dynamic>>? metaData;

  List<ProductBrand?>? brands;

  @JsonKey(name: 'price_html')
  String? priceHtml;

  Product({
    this.id,
    this.name,
    this.slug,
    this.type,
    this.status,
    this.description,
    this.sku,
    this.shortDescription,
    this.images,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.onSale,
    this.date,
    this.averageRating,
    this.ratingCount,
    this.formatPrice,
    this.catalogVisibility,
    this.stockStatus,
    this.manageStock,
    this.stockQuantity,
    this.relatedIds,
    this.upsellIds,
    this.groupedIds,
    this.categories,
    this.externalUrl,
    this.buttonText,
    this.purchasable,
    this.store,
    this.attributes,
    this.parentId,
    this.metaData,
    this.brands,
    this.priceHtml,
  });

  static String _toUnescape(dynamic value) {
    if (value is! String) return '';
    return value.unescape;
  }

  static String _fromJson(dynamic value) {
    if (value == '') return '0';
    if (value is String) return value;
    if (value is int || value is double) return value.toString();
    return '0';
  }

  static List<Map<String, dynamic>> _fromJsonImage(dynamic data) {
    if (data is! List) return [];
    List<Map<String, dynamic>> value = [];
    for (int i = 0; i < data.length; i++) {
      if (data[i] is Map) {
        value.add(data[i]);
      }
    }
    return value;
  }

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  factory Product.fromVariation(Map<String, dynamic> json) => _productFromVariation(json);
}

Product _productFromVariation(dynamic json) {
  Map<String, dynamic> product = Map<String, dynamic>.of(json);
  product.update('attributes', (value) => null, ifAbsent: () => null);
  return Product.fromJson(product);
}

class ProductBlocks {
  ProductBlocks._();

  static const String category = 'Category';
  static const String name = 'Name';
  static const String rating = 'Rating';
  static const String price = 'Price';
  static const String status = 'Status';
  static const String type = 'Type';
  static const String quantity = 'Quantity';
  static const String sortDescription = 'SortDescription';
  static const String description = 'Description';
  static const String sku = 'sku';
  static const String additionInformation = 'AdditionInformation';
  static const String review = 'Review';
  static const String relatedProduct = 'RelatedProduct';
  static const String upsellProduct = 'UpsellProduct';
  static const String addToCart = 'AddToCart';
  static const String action = 'Action';
  static const String custom = 'Custom';
  static const String store = 'Store';
  static const String featuredImage = 'FeaturedImage';
  static const String addOns = 'AddOns';
  static const String brand = 'Brand';
  static const String html = 'Html';
}
