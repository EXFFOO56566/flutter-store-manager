part of 'variation_bloc.dart';

abstract class VariationEvent extends Equatable {
  const VariationEvent();

  @override
  List<Object> get props => [];
}

///
/// Product Attribute event
///
class AttributeChanged extends VariationEvent {
  const AttributeChanged(this.attribute);

  final DefaultAttributeData attribute;

  @override
  List<Object> get props => [attribute];
}

///
/// Product Status type event
///
class StatusTypeChanged extends VariationEvent {
  const StatusTypeChanged(this.type);

  final String type;

  @override
  List<Object> get props => [type];
}

///
/// Product Downloadable type event
///
class DownloadableChanged extends VariationEvent {
  const DownloadableChanged(this.value);

  final bool value;

  @override
  List<Object> get props => [value];
}

///
/// Product Virtual type event
///
class VirtualChanged extends VariationEvent {
  const VirtualChanged(this.value);

  final bool value;

  @override
  List<Object> get props => [value];
}

///
/// Product Manage stock type event
///
class ManageStockChanged extends VariationEvent {
  const ManageStockChanged(this.value);

  final bool value;

  @override
  List<Object> get props => [value];
}

///
/// Product regular price event
///
class RegularPriceChanged extends VariationEvent {
  const RegularPriceChanged(this.regularPrice);

  final String regularPrice;

  @override
  List<Object> get props => [regularPrice];
}

///
/// Product sale price type event
///
class SalePriceChanged extends VariationEvent {
  const SalePriceChanged(this.salePrice);

  final String salePrice;

  @override
  List<Object> get props => [salePrice];
}

///
/// Product image type event
///
class ImageChanged extends VariationEvent {
  const ImageChanged(this.image);

  final ImageData? image;

  @override
  List<Object> get props => image != null ? [image!] : [];
}

///
/// Product stock quantity type event
///
class StockQuantityChanged extends VariationEvent {
  const StockQuantityChanged(this.stockQuantity);

  final String? stockQuantity;

  @override
  List<Object> get props => [stockQuantity ?? ''];
}

///
/// Product backorders type event
///
class BackordersChanged extends VariationEvent {
  const BackordersChanged(this.backorders);

  final String backorders;

  @override
  List<Object> get props => [backorders];
}

///
/// Product sku type event
///
class SkuChanged extends VariationEvent {
  const SkuChanged(this.sku);

  final String sku;

  @override
  List<Object> get props => [sku];
}

///
/// Product stock status type event
///
class StockStatusChanged extends VariationEvent {
  const StockStatusChanged(this.stockStatus);

  final String stockStatus;

  @override
  List<Object> get props => [stockStatus];
}

///
/// Product weight type event
///
class WeightChanged extends VariationEvent {
  const WeightChanged(this.weight);

  final String weight;

  @override
  List<Object> get props => [weight];
}

///
/// Product length type event
///
class LengthChanged extends VariationEvent {
  const LengthChanged(this.length);

  final String length;

  @override
  List<Object> get props => [length];
}

///
/// Product width type event
///
class WidthChanged extends VariationEvent {
  const WidthChanged(this.width);

  final String width;

  @override
  List<Object> get props => [width];
}

///
/// Product height type event
///
class HeightChanged extends VariationEvent {
  const HeightChanged(this.height);

  final String height;

  @override
  List<Object> get props => [height];
}

///
/// Product shipping class type event
///
class ShippingClassChanged extends VariationEvent {
  const ShippingClassChanged(this.shippingClass);

  final String shippingClass;

  @override
  List<Object> get props => [shippingClass];
}

///
/// Product tax class type event
///
class TaxClassChanged extends VariationEvent {
  const TaxClassChanged(this.taxClass);

  final String taxClass;

  @override
  List<Object> get props => [taxClass];
}

///
/// Product description type event
///
class DescriptionChanged extends VariationEvent {
  const DescriptionChanged(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}

class VariationUpdateSubmitted extends VariationEvent {
  const VariationUpdateSubmitted();
}

class VariationAddSubmitted extends VariationEvent {
  const VariationAddSubmitted();
}
