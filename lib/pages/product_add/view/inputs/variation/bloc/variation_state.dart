part of 'variation_bloc.dart';

class VariationState extends Equatable {
  const VariationState({
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.id,
    this.attributes = const ListAttribute.pure(),
    this.statusType = const Status.pure(),
    this.downloadable = const Downloadable.pure(),
    this.virtual = const Virtual.pure(),
    this.manageStock = const ManageStock.pure(),
    this.regularPrice = const RegularPrice.pure(),
    this.salePrice = const SalePrice.pure(),
    this.backorders = const Backorders.pure(),
    this.description = const Description.pure(),
    this.height = const Height.pure(),
    this.image = const Image.pure(),
    this.length = const Length.pure(),
    this.shippingClass = const ShippingClass.pure(),
    this.sku = const Sku.pure(),
    this.stockQuantity = const StockQuantity.pure(),
    this.stockStatus = const StockStatus.pure(),
    this.taxClass = const TaxClass.pure(),
    this.weight = const Weight.pure(),
    this.width = const Width.pure(),
  });

  /// Form data status
  final FormzStatus status;
  final String? errorMessage;

  /// Id
  final int? id;
  final ListAttribute attributes;
  final Status statusType;
  final Downloadable downloadable;
  final Virtual virtual;
  final ManageStock manageStock;
  final RegularPrice regularPrice;
  final SalePrice salePrice;
  final Backorders backorders;
  final Description description;
  final Height height;
  final Image image;
  final Length length;
  final ShippingClass shippingClass;
  final Sku sku;
  final StockQuantity stockQuantity;
  final StockStatus stockStatus;
  final TaxClass taxClass;
  final Weight weight;
  final Width width;

  VariationState copyWith({
    FormzStatus? status,
    String? errorMessage,
    int? id,
    ListAttribute? attributes,
    Status? statusType,
    Downloadable? downloadable,
    Virtual? virtual,
    ManageStock? manageStock,
    RegularPrice? regularPrice,
    SalePrice? salePrice,
    Backorders? backorders,
    Description? description,
    Height? height,
    Image? image,
    Length? length,
    ShippingClass? shippingClass,
    Sku? sku,
    StockQuantity? stockQuantity,
    StockStatus? stockStatus,
    TaxClass? taxClass,
    Weight? weight,
    Width? width,
  }) {
    return VariationState(
        id: id ?? this.id,
        attributes: attributes ?? this.attributes,
        statusType: statusType ?? this.statusType,
        downloadable: downloadable ?? this.downloadable,
        virtual: virtual ?? this.virtual,
        manageStock: manageStock ?? this.manageStock,
        regularPrice: regularPrice ?? this.regularPrice,
        salePrice: salePrice ?? this.salePrice,
        backorders: backorders ?? this.backorders,
        description: description ?? this.description,
        height: height ?? this.height,
        image: image ?? this.image,
        length: length ?? this.length,
        shippingClass: shippingClass ?? this.shippingClass,
        sku: sku ?? this.sku,
        stockQuantity: stockQuantity ?? this.stockQuantity,
        stockStatus: stockStatus ?? this.stockStatus,
        taxClass: taxClass ?? this.taxClass,
        weight: weight ?? this.weight,
        width: width ?? this.width,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object> get props => [
        status,
        attributes,
        statusType,
        downloadable,
        virtual,
        manageStock,
        regularPrice,
        salePrice,
        backorders,
        description,
        height,
        image,
        length,
        shippingClass,
        sku,
        stockQuantity,
        stockStatus,
        taxClass,
        weight,
        width,
      ];

  factory VariationState.fromJson(Map<String, dynamic> json, String skuParent) => _variationFromJson(json, skuParent);

  Map<String, dynamic> toJson() => _variationToJson(this);
}

/// Convert variation state from Json
VariationState _variationFromJson(Map<String, dynamic> json, String skuParent) {
  // Variation attributes
  List<dynamic> defaultAttribute = json['attributes'] ?? [];
  List<DefaultAttributeData> attributes = <DefaultAttributeData>[];
  attributes =
      defaultAttribute.map((attr) => DefaultAttributeData.fromJson(attr)).toList().cast<DefaultAttributeData>();

  dynamic getImage = get(json, ['image'], null);
  ImageData? image = getImage is Map<String, dynamic> ? ImageData.fromJson(getImage) : null;

  String regularPrice = json['regular_price'] ?? '';
  String salePrice = json['sale_price'] ?? '';
  String height = get(json, ['dimensions', 'height'], '');
  String length = get(json, ['dimensions', 'length'], '');
  String width = get(json, ['dimensions', 'width'], '');

  bool valueManageStock = json['manage_stock'] is bool ? json['manage_stock'] : false;
  ManageStock manageStock = ManageStock.dirty(valueManageStock);
  String? stockQuantity = get(json, ['stock_quantity'], '') != null ? '${get(json, ['stock_quantity'], '')}' : null;

  String sku = json['sku'] ?? '';
  String valueSku = skuParent.trim() != sku.trim() ? sku : '';

  return VariationState(
    id: json['id'],
    attributes: ListAttribute.dirty(attributes),
    statusType: Status.dirty(json['status'] ?? 'publish'),
    downloadable: Downloadable.dirty(json['downloadable'] ?? false),
    virtual: Virtual.dirty(json['virtual'] ?? false),
    manageStock: manageStock,
    regularPrice: RegularPrice.pure(regularPrice),
    salePrice: SalePrice.pure(regularPrice: regularPrice, value: salePrice),
    backorders: Backorders.dirty(json['backorders'] ?? 'no'),
    description: Description.dirty(json['description'] ?? ''),
    height: Height.pure(height),
    image: Image.dirty(image),
    length: Length.pure(length),
    shippingClass: ShippingClass.dirty(json['shipping_class'] ?? ''),
    sku: Sku.dirty(valueSku),
    stockQuantity: StockQuantity.pure(manageStock: manageStock.value, value: stockQuantity),
    stockStatus: StockStatus.dirty(json['stock_status'] ?? 'instock'),
    taxClass: TaxClass.dirty(json['tax_class'] ?? ''),
    weight: Weight.pure(json['weight'] ?? ''),
    width: Width.pure(width),
  );
}

/// Convert variation instance to Json
Map<String, dynamic> _variationToJson(VariationState instance) {
  return <String, dynamic>{
    'id': instance.id,
    'attributes': instance.attributes.value.map((e) => e.toJson()).toList(),
    'status': instance.statusType.value,
    'downloadable': instance.downloadable.value,
    'virtual': instance.virtual.value,
    'manage_stock': instance.manageStock.value,
    'regular_price': instance.regularPrice.value,
    'sale_price': instance.salePrice.value,
    'backorders': instance.backorders.value,
    'description': instance.description.value,
    'image': null,
    'shipping_class': instance.shippingClass.value,
    'sku': instance.sku.value,
    'stock_quantity':
        instance.stockQuantity.value != null ? ConvertData.stringToInt(instance.stockQuantity.value) : null,
    'stock_status': instance.stockStatus.value,
    'tax_class': instance.taxClass.value,
    'dimensions': {'length': instance.length.value, 'width': instance.width.value, 'height': instance.height.value},
    'weight': instance.weight.value,
  };
}
