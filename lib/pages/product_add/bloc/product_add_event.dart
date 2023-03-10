part of 'product_add_bloc.dart';

abstract class ProductAddEvent extends Equatable {
  const ProductAddEvent();

  @override
  List<Object> get props => [];
}

///
/// Product Type event
///
class TypeChanged extends ProductAddEvent {
  const TypeChanged(this.type);

  final String type;

  @override
  List<Object> get props => [type];
}

///
/// Product Name event
///
class NameChanged extends ProductAddEvent {
  const NameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

///
/// Product Regular price event
///
class RegularPriceChanged extends ProductAddEvent {
  const RegularPriceChanged(this.regularPrice);

  final String regularPrice;

  @override
  List<Object> get props => [regularPrice];
}

class SalePriceChanged extends ProductAddEvent {
  const SalePriceChanged(this.salePrice);

  final String salePrice;

  @override
  List<Object> get props => [salePrice];
}

class SkuChanged extends ProductAddEvent {
  const SkuChanged(this.sku);

  final String sku;

  @override
  List<Object> get props => [sku];
}

class StockQuantityChanged extends ProductAddEvent {
  const StockQuantityChanged(this.stockQuantity);

  final String? stockQuantity;

  @override
  List<Object> get props => stockQuantity != null ? [stockQuantity!] : [];
}

class ManagerStockChanged extends ProductAddEvent {
  const ManagerStockChanged(this.managerStock);

  final bool managerStock;

  @override
  List<Object> get props => [managerStock];
}

class SoldIndividuallyChanged extends ProductAddEvent {
  const SoldIndividuallyChanged(this.soldIndividually);

  final bool soldIndividually;

  @override
  List<Object> get props => [soldIndividually];
}

class StockStatusChanged extends ProductAddEvent {
  const StockStatusChanged(this.stockStatus);

  final String stockStatus;

  @override
  List<Object> get props => [stockStatus];
}

class BackordersChanged extends ProductAddEvent {
  const BackordersChanged(this.backorders);

  final String backorders;

  @override
  List<Object> get props => [backorders];
}

class DescriptionChanged extends ProductAddEvent {
  const DescriptionChanged(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}

class WeightChanged extends ProductAddEvent {
  const WeightChanged(this.weight);

  final String weight;

  @override
  List<Object> get props => [weight];
}

class LengthChanged extends ProductAddEvent {
  const LengthChanged(this.length);

  final String length;

  @override
  List<Object> get props => [length];
}

class WidthChanged extends ProductAddEvent {
  const WidthChanged(this.width);

  final String width;

  @override
  List<Object> get props => [width];
}

class HeightChanged extends ProductAddEvent {
  const HeightChanged(this.height);

  final String height;

  @override
  List<Object> get props => [height];
}

class ProductDataChanged extends ProductAddEvent {
  const ProductDataChanged(this.data);

  final Map<String, dynamic> data;

  @override
  List<Object> get props => [data];
}

class AddAttributeChanged extends ProductAddEvent {
  const AddAttributeChanged(this.attributes);

  final List<AttributeData> attributes;

  @override
  List<Object> get props => [attributes];
}

class DeleteAttributeChanged extends ProductAddEvent {
  const DeleteAttributeChanged(this.keyAttribute);

  final String keyAttribute;

  @override
  List<Object> get props => [keyAttribute];
}

class UpdateAttributeChanged extends ProductAddEvent {
  const UpdateAttributeChanged(this.attribute);

  final AttributeData attribute;

  @override
  List<Object> get props => [attribute];
}

class DefaultAttributeChanged extends ProductAddEvent {
  const DefaultAttributeChanged(this.defaultAttribute);

  final DefaultAttributeData defaultAttribute;

  @override
  List<Object> get props => [defaultAttribute];
}

class VariationChanged extends ProductAddEvent {
  const VariationChanged(this.idVariation);

  final int idVariation;

  @override
  List<Object> get props => [idVariation];
}

class ImageChanged extends ProductAddEvent {
  const ImageChanged(this.image);

  final ImageData image;

  @override
  List<Object> get props => [image];
}

class ImageDeletedChanged extends ProductAddEvent {
  const ImageDeletedChanged();

  @override
  List<Object> get props => [];
}

class ImageDeletedGalleryChanged extends ProductAddEvent {
  const ImageDeletedGalleryChanged(this.image);

  final ImageData image;

  @override
  List<Object> get props => [image];
}

class GalleryChanged extends ProductAddEvent {
  const GalleryChanged(this.images);

  final List<ImageData> images;

  @override
  List<Object> get props => [images];
}

class CategoriesChanged extends ProductAddEvent {
  const CategoriesChanged(this.categories);

  final List<Category> categories;

  @override
  List<Object> get props => [categories];
}

class CatalogVisibilityChanged extends ProductAddEvent {
  const CatalogVisibilityChanged(this.catalogVisibility);

  final String catalogVisibility;

  @override
  List<Object> get props => [catalogVisibility];
}

class ExternalUrlChanged extends ProductAddEvent {
  const ExternalUrlChanged(this.externalUrl);

  final String externalUrl;

  @override
  List<Object> get props => [externalUrl];
}

class ButtonTextChanged extends ProductAddEvent {
  const ButtonTextChanged(this.buttonText);

  final String buttonText;

  @override
  List<Object> get props => [buttonText];
}

class GroupedProductChanged extends ProductAddEvent {
  const GroupedProductChanged(this.idProduct);

  final int idProduct;

  @override
  List<Object> get props => [idProduct];
}

class ProductAttributeSubmitted extends ProductAddEvent {
  const ProductAttributeSubmitted();
}

class ProductAddSubmitted extends ProductAddEvent {
  const ProductAddSubmitted(this.status);
  final String status;

  @override
  List<Object> get props => [status];
}

class ProductDeleteSubmitted extends ProductAddEvent {
  const ProductDeleteSubmitted();
}
