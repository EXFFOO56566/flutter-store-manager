part of 'product_add_bloc.dart';

class ProductAddState extends Equatable {
  const ProductAddState({
    this.status = FormzStatus.pure,
    this.enableDraft = true,
    this.statusAttribute = FormzStatus.pure,
    this.changeStatus = false,
    this.messageError,
    this.messageAttributeError,
    this.skuParent = '',
    required this.id,
    this.type = const Type.pure(),
    this.name = const Name.pure(),
    this.regularPrice = const RegularPrice.pure(),
    this.salePrice = const SalePrice.pure(),
    this.managerStock = const ManagerStock.pure(),
    this.sku = const Sku.pure(),
    this.stockQuantity = const StockQuantity.pure(),
    this.stockStatus = const StockStatus.pure(),
    this.soldIndividually = const SoldIndividually.pure(),
    this.backorders = const Backorders.pure(),
    this.description = const Description.pure(),
    this.categories = const ListCategory.pure(),
    this.attributes = const ListAttribute.pure(),
    this.defaultAttributes = const ListDefaultAttribute.pure(),
    this.catalogVisibility = const CatalogVisibility.pure(),
    this.data = const {},
    this.image = const Image.pure(),
    this.gallery = const Gallery.pure(),
    this.variations = const ListVariation.pure(),
    this.externalUrl = const ExternalUrl.pure(),
    this.buttonText = const ButtonText.pure(),
    this.groupedProducts = const GroupedProduct.pure(),
  });

  /// Form data status
  final FormzStatus status;
  final bool enableDraft;
  final FormzStatus statusAttribute;
  final String? messageError;
  final String? messageAttributeError;
  final bool changeStatus;
  final String skuParent;

  /// Id
  final int id;

  /// Inputs
  final Type type;
  final Name name;
  final RegularPrice regularPrice;
  final SalePrice salePrice;
  final ManagerStock managerStock;
  final Sku sku;
  final StockQuantity stockQuantity;
  final StockStatus stockStatus;
  final SoldIndividually soldIndividually;
  final Backorders backorders;
  final Description description;
  final ListAttribute attributes;
  final ListDefaultAttribute defaultAttributes;
  final ListCategory categories;

  // final ImageChanged images;
  final CatalogVisibility catalogVisibility;
  final Map<String, dynamic> data;

  // Product feature image
  final Image image;

  // Product gallery
  final Gallery gallery;

  final ListVariation variations;

  final ExternalUrl externalUrl;
  final ButtonText buttonText;
  final GroupedProduct groupedProducts;

  ProductAddState copyWith({
    FormzStatus? status,
    bool? enableDraft,
    FormzStatus? statusAttribute,
    String? messageError,
    String? messageAttributeError,
    bool? changeStatus,
    String? skuParent,
    Type? type,
    Name? name,
    RegularPrice? regularPrice,
    SalePrice? salePrice,
    Sku? sku,
    StockQuantity? stockQuantity,
    StockStatus? stockStatus,
    SoldIndividually? soldIndividually,
    ManagerStock? managerStock,
    Backorders? backorders,
    Description? description,
    ListAttribute? attributes,
    ListDefaultAttribute? defaultAttributes,
    ListCategory? categories,
    ImageChanged? images,
    CatalogVisibility? catalogVisibility,
    Map<String, dynamic>? data,
    Image? image,
    Gallery? gallery,
    ListVariation? variations,
    ExternalUrl? externalUrl,
    ButtonText? buttonText,
    GroupedProduct? groupedProducts,
  }) {
    return ProductAddState(
      id: id,
      status: status ?? this.status,
      enableDraft: enableDraft ?? this.enableDraft,
      statusAttribute: statusAttribute ?? this.statusAttribute,
      messageError: messageError ?? this.messageError,
      messageAttributeError: messageAttributeError ?? this.messageAttributeError,
      changeStatus: changeStatus ?? this.changeStatus,
      skuParent: skuParent ?? this.skuParent,
      type: type ?? this.type,
      name: name ?? this.name,
      regularPrice: regularPrice ?? this.regularPrice,
      salePrice: salePrice ?? this.salePrice,
      sku: sku ?? this.sku,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      stockStatus: stockStatus ?? this.stockStatus,
      managerStock: managerStock ?? this.managerStock,
      soldIndividually: soldIndividually ?? this.soldIndividually,
      backorders: backorders ?? this.backorders,
      description: description ?? this.description,
      attributes: attributes ?? this.attributes,
      defaultAttributes: defaultAttributes ?? this.defaultAttributes,
      variations: variations ?? this.variations,
      categories: categories ?? this.categories,
      catalogVisibility: catalogVisibility ?? this.catalogVisibility,
      data: data ?? this.data,
      image: image ?? this.image,
      gallery: gallery ?? this.gallery,
      externalUrl: externalUrl ?? this.externalUrl,
      buttonText: buttonText ?? this.buttonText,
      groupedProducts: groupedProducts ?? this.groupedProducts,
    );
  }

  @override
  List<Object> get props => [
        status,
        enableDraft,
        statusAttribute,
        messageError ?? '',
        messageAttributeError ?? '',
        skuParent,
        type,
        name,
        regularPrice,
        salePrice,
        sku,
        stockQuantity,
        stockStatus,
        managerStock,
        soldIndividually,
        backorders,
        description,
        data,
        attributes,
        defaultAttributes,
        variations,
        categories,
        catalogVisibility,
        image,
        gallery,
        externalUrl,
        buttonText,
        groupedProducts,
      ];

  factory ProductAddState.fromJson(Map<String, dynamic> json) => _productFromJson(json);

  Map<String, dynamic> toJson() => _productToJson(this);
}

/// Convert product state from Json
ProductAddState _productFromJson(Map<String, dynamic> json) {
  String nameText = json['name'] ?? '';
  Name name = Name.pure(nameText.unescape);
  Type type = Type.dirty(json['type'] ?? 'simple');
  Sku sku = Sku.dirty(json['sku'] ?? '');
  String descriptionText = json['description'] ?? '';
  Description description = Description.dirty(descriptionText.unescape);
  ManagerStock managerStock = ManagerStock.dirty(json['manage_stock'] ?? false);
  final valueStockQuantity = json['stock_quantity'];
  String? valueQuantity = valueStockQuantity is int
      ? valueStockQuantity.toString()
      : valueStockQuantity is String && valueStockQuantity.isNotEmpty == true
          ? valueStockQuantity
          : null;
  StockQuantity stockQuantity = StockQuantity.pure(manageStock: managerStock.value, value: valueQuantity);
  StockStatus stockStatus = StockStatus.dirty(json['stock_status'] ?? 'instock');
  Backorders backorders = Backorders.dirty(json['backorders'] ?? 'no');
  SoldIndividually soldIndividually = SoldIndividually.dirty(json['sold_individually'] ?? false);
  CatalogVisibility catalogVisibility = CatalogVisibility.dirty(json['catalog_visibility'] ?? 'visible');
  ExternalUrl externalUrl = ExternalUrl.dirty(json['external_url'] ?? "");
  ButtonText buttonText = ButtonText.dirty(json['button_text'] ?? "");

  RegularPrice regularPrice = RegularPrice.pure(type: type.value, value: json['regular_price'] ?? '');
  SalePrice salePrice =
      SalePrice.pure(type: type.value, regularPrice: regularPrice.value, value: json['sale_price'] ?? '');

  // Product categories
  List<dynamic> productCategories = json['categories'] ?? [];
  List<Category> categories = <Category>[];
  categories = productCategories.map((category) => Category.fromJson(category)).toList().cast<Category>();

  // Product attributes
  List<dynamic> productAttributes = json['attributes'] ?? [];
  List<AttributeData> attributes = <AttributeData>[];
  attributes = productAttributes.map((attr) => AttributeData.fromJson(attr)).toList().cast<AttributeData>();

  // Product default attributes
  List<dynamic> productDefaultAttributes = json['default_attributes'] ?? [];
  List<DefaultAttributeData> defaultAttributes = <DefaultAttributeData>[];
  defaultAttributes =
      productDefaultAttributes.map((attr) => DefaultAttributeData.fromJson(attr)).toList().cast<DefaultAttributeData>();

  // Feature image
  List<dynamic> productImages = json['images'];
  dynamic featureImage = productImages.isNotEmpty ? productImages[0] : null;

  // Gallery
  List<ImageData> galleryImages = <ImageData>[];
  if (productImages.length > 1) {
    productImages.removeAt(0);
    galleryImages = productImages.map((e) => ImageData.fromJson(e)).toList().cast<ImageData>();
  }

  // Variations
  List<dynamic> variationsData = json['variations'];

  List<int> variations = <int>[];
  if (variationsData.isNotEmpty) {
    variations = variationsData.map((e) => ConvertData.stringToInt(e)).toSet().toList().cast<int>();
  }

  // grouped product id
  List<dynamic> productIdsData = json['grouped_products'];

  List<int> groupedProducts = <int>[];
  if (productIdsData.isNotEmpty) {
    groupedProducts = productIdsData.map((e) => ConvertData.stringToInt(e)).toSet().toList().cast<int>();
  }

  return ProductAddState(
    id: json['id'] as int,
    name: name,
    type: type,
    regularPrice: regularPrice,
    salePrice: salePrice,
    sku: sku,
    skuParent: sku.value,
    stockQuantity: stockQuantity,
    stockStatus: stockStatus,
    managerStock: managerStock,
    soldIndividually: soldIndividually,
    backorders: backorders,
    description: description,
    externalUrl: externalUrl,
    buttonText: buttonText,
    categories: ListCategory.dirty(categories),
    attributes: ListAttribute.dirty(attributes),
    defaultAttributes: ListDefaultAttribute.dirty(defaultAttributes),
    catalogVisibility: catalogVisibility,
    // images: ImageChanged(json['images'] ?? []),
    status: Formz.validate([name, type]),
    image: featureImage != null ? Image.dirty(ImageData.fromJson(featureImage)) : const Image.pure(),
    gallery: galleryImages.isNotEmpty ? Gallery.dirty(galleryImages) : const Gallery.pure(),
    variations: variations.isNotEmpty ? ListVariation.dirty(variations) : const ListVariation.pure(),
    groupedProducts: groupedProducts.isNotEmpty ? GroupedProduct.dirty(groupedProducts) : const GroupedProduct.pure(),
  );
}

/// Convert product instance to Json
Map<String, dynamic> _productToJson(ProductAddState instance) {
  return <String, dynamic>{
    'name': instance.name.value,
    'type': instance.type.value,
    'sku': instance.sku.value,
    'regular_price': instance.regularPrice.value,
    'sale_price': instance.salePrice.value,
    'description': instance.description.value,
    'manage_stock': instance.managerStock.value,
    'stock_quantity': instance.stockQuantity.value,
    'stock_status': instance.stockStatus.value,
    'sold_individually': instance.soldIndividually.value,
    'backorders': instance.backorders.value,
    'catalog_visibility': instance.catalogVisibility.value,
    'categories': instance.categories.value.map((Category e) => e.toJson()).toList(),
    'attributes': instance.attributes.value.map((AttributeData e) => e.toJson()).toList(),
    'default_attributes': instance.defaultAttributes.value.map((DefaultAttributeData e) => e.toJson()).toList(),
    'images': [], // Pre images data later
    'variations': instance.variations.value,
    'external_url': instance.externalUrl.value,
    'button_text': instance.buttonText.value,
    'grouped_products': instance.groupedProducts.value,
  };
}
