// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as int?,
      name: Product._toUnescape(json['name']),
      slug: json['slug'] as String?,
      type: $enumDecodeNullable(_$ProductTypeEnumMap, json['type']),
      status: json['status'] as String?,
      description: Product._toUnescape(json['description']),
      sku: json['sku'] as String?,
      shortDescription: Product._toUnescape(json['short_description']),
      images: Product._fromJsonImage(json['images']),
      price: Product._fromJson(json['price']),
      regularPrice: Product._fromJson(json['regular_price']),
      salePrice: Product._fromJson(json['sale_price']),
      onSale: json['on_sale'] as bool?,
      date: json['date_created'] as String?,
      averageRating: json['average_rating'] as String?,
      ratingCount: json['rating_count'] as int?,
      formatPrice: json['format_price'] == null
          ? null
          : ProductPriceFormat.fromJson(json['format_price'] as Map<String, dynamic>),
      catalogVisibility: json['catalog_visibility'] as String?,
      stockStatus: json['stock_status'] as String?,
      manageStock: json['manage_stock'] as bool?,
      stockQuantity: json['stock_quantity'] as int? ?? 0,
      relatedIds: (json['related_ids'] as List<dynamic>?)?.map((e) => e as int).toList(),
      upsellIds: (json['upsell_ids'] as List<dynamic>?)?.map((e) => e as int).toList(),
      groupedIds: (json['grouped_products'] as List<dynamic>?)?.map((e) => e as int).toList(),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => e == null ? null : ProductCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
      externalUrl: json['external_url'] as String?,
      buttonText: json['button_text'] as String?,
      purchasable: json['purchasable'] as bool?,
      store: json['store'] as Map<String, dynamic>?,
      attributes: (json['attributes'] as List<dynamic>?)?.map((e) => e as Map<String, dynamic>).toList(),
      parentId: json['parent_id'] as int? ?? 0,
      metaData: (json['meta_data'] as List<dynamic>?)?.map((e) => e as Map<String, dynamic>).toList(),
      brands: (json['brands'] as List<dynamic>?)
          ?.map((e) => e == null ? null : ProductBrand.fromJson(e as Map<String, dynamic>))
          .toList(),
      priceHtml: json['price_html'] as String?,
    )..permalink = json['permalink'] as String?;

const _$ProductTypeEnumMap = {
  ProductTypeModel.simple: 'simple',
  ProductTypeModel.grouped: 'grouped',
  ProductTypeModel.external: 'external',
  ProductTypeModel.variable: 'variable',
  ProductTypeModel.variation: 'variation',
};
