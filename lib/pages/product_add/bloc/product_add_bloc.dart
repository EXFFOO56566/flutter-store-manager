import 'package:bloc/bloc.dart';
import 'package:category_repository/category_repository.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_store_manager/common/widgets/image/image.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:formz/formz.dart';
import 'package:media_repository/media_repository.dart';
import 'package:products_repository/products_repository.dart';
import '../view/inputs/default_attribute/default_attribute.dart';

// Models
import '../models/models.dart';

part 'product_add_event.dart';
part 'product_add_state.dart';

class ProductAddBloc extends Bloc<ProductAddEvent, ProductAddState> {
  final ProductsRepository productsRepository;
  final MediaRepository mediaRepository;
  final String token;
  final RequestCancel _cancelToken = RequestCancel();

  final Map<String, dynamic> product;

  ProductAddBloc({
    required this.productsRepository,
    required this.mediaRepository,
    required this.token,
    required this.product,
  }) : super(ProductAddState.fromJson(product)) {
    on<NameChanged>(_onNameChanged);
    on<RegularPriceChanged>(_onRegularPriceChanged);
    on<SalePriceChanged>(_onSalePriceChanged);
    on<SkuChanged>(_onSkuChanged);
    on<StockQuantityChanged>(_onStockQuantityChanged);
    on<StockStatusChanged>(_onStockStatusChanged);
    on<ManagerStockChanged>(_onManagerStockChanged);
    on<SoldIndividuallyChanged>(_onSoldIndividuallyChanged);
    on<BackordersChanged>(_onBackordersChanged);
    on<DescriptionChanged>(_onDescriptionChanged);
    on<WeightChanged>(_onWeightChanged);
    on<LengthChanged>(_onLengthChanged);
    on<WidthChanged>(_onWidthChanged);
    on<HeightChanged>(_onHeightChanged);
    on<ProductAddSubmitted>(_onSubmitted);
    on<UpdateAttributeChanged>(_onUpdateAttributesChanged);
    on<AddAttributeChanged>(_onAddAttributesChanged);
    on<DeleteAttributeChanged>(_onDeleteAttributesChanged);
    on<DefaultAttributeChanged>(_onDefaultAttributesChanged);
    on<VariationChanged>(_onVariationChanged);
    on<ImageChanged>(_onImageChanged);
    on<ImageDeletedGalleryChanged>(_onImageDeleteGalleryChanged);
    on<ImageDeletedChanged>(_onImageDeleteChanged);
    on<GalleryChanged>(_onGalleryChanged);
    on<CategoriesChanged>(_onCategoriesChanged);
    on<CatalogVisibilityChanged>(_onCatalogVisibilityChanged);
    on<TypeChanged>(_onTypeChanged);
    on<ExternalUrlChanged>(_onExternalUrlChanged);
    on<GroupedProductChanged>(_onGroupedProductChanged);
    on<ButtonTextChanged>(_onButtonTextChanged);
    on<ProductAttributeSubmitted>(_saveAttribute);
    on<ProductDeleteSubmitted>(_deleteProduct);
  }

  List<dynamic> images = [];
  String valueSku = '';
  int valueStockQuantity = 0;
  String valueDescription = '';
  String valueWeight = '';
  String valueLength = '';
  String valueWidth = '';
  String valueHeight = '';
  List<dynamic> imageSrcList = [];
  Map<String, dynamic> data = {};
  List<Map<String, dynamic>> attributes = [];

  void _onTypeChanged(TypeChanged event, Emitter<ProductAddState> emit) async {
    final type = Type.dirty(event.type);
    final regularPrice = state.regularPrice.value.isNotEmpty
        ? RegularPrice.dirty(type: state.type.value, value: state.regularPrice.value)
        : state.regularPrice;
    final salePrice = state.salePrice.value.isNotEmpty
        ? SalePrice.dirty(
            type: event.type,
            regularPrice: state.regularPrice.value,
            value: state.salePrice.value,
          )
        : state.salePrice;
    emit(state.copyWith(
      type: type,
      regularPrice: regularPrice,
      salePrice: salePrice,
      status: Formz.validate([regularPrice, salePrice, type]),
    ));
  }

  void _onNameChanged(NameChanged event, Emitter<ProductAddState> emit) {
    final name = Name.dirty(event.name);
    emit(state.copyWith(
      name: name,
      status: Formz.validate([name, state.regularPrice, state.salePrice]),
    ));
  }

  void _onRegularPriceChanged(RegularPriceChanged event, Emitter<ProductAddState> emit) {
    final regularPrice = RegularPrice.dirty(type: state.type.value, value: event.regularPrice);
    final salePrice = SalePrice.dirty(
      type: state.type.value,
      regularPrice: event.regularPrice,
      value: state.salePrice.value,
    );
    emit(state.copyWith(
      regularPrice: regularPrice,
      salePrice: salePrice,
      status: Formz.validate([regularPrice, salePrice, state.name]),
    ));
  }

  void _onSalePriceChanged(SalePriceChanged event, Emitter<ProductAddState> emit) {
    final salePrice = SalePrice.dirty(
      type: state.type.value,
      regularPrice: state.regularPrice.value,
      value: event.salePrice,
    );
    emit(state.copyWith(
      salePrice: salePrice,
      status: Formz.validate([state.regularPrice, salePrice]),
    ));
  }

  void _onSkuChanged(SkuChanged event, Emitter<ProductAddState> emit) {
    final sku = Sku.dirty(event.sku);
    emit(state.copyWith(
      sku: sku,
      status: Formz.validate([sku]),
    ));
  }

  void _onStockQuantityChanged(StockQuantityChanged event, Emitter<ProductAddState> emit) {
    final stockQuantity = StockQuantity.dirty(manageStock: state.managerStock.value, value: event.stockQuantity);
    emit(state.copyWith(
      stockQuantity: stockQuantity,
      status: Formz.validate([stockQuantity]),
    ));
  }

  void _onStockStatusChanged(StockStatusChanged event, Emitter<ProductAddState> emit) {
    final stockStatus = StockStatus.dirty(event.stockStatus);
    emit(state.copyWith(
      stockStatus: stockStatus,
      status: Formz.validate([stockStatus]),
    ));
  }

  void _onManagerStockChanged(ManagerStockChanged event, Emitter<ProductAddState> emit) {
    final managerStock = ManagerStock.dirty(event.managerStock);
    final stockQuantity = StockQuantity.dirty(manageStock: event.managerStock, value: state.stockQuantity.value);
    emit(state.copyWith(
      managerStock: managerStock,
      stockQuantity: stockQuantity,
      status: Formz.validate([managerStock, stockQuantity]),
    ));
  }

  void _onSoldIndividuallyChanged(SoldIndividuallyChanged event, Emitter<ProductAddState> emit) {
    final soldIndividually = SoldIndividually.dirty(event.soldIndividually);
    emit(state.copyWith(
      soldIndividually: soldIndividually,
      status: Formz.validate([soldIndividually]),
    ));
  }

  void _onBackordersChanged(BackordersChanged event, Emitter<ProductAddState> emit) {
    final backorders = Backorders.dirty(event.backorders);
    emit(state.copyWith(
      backorders: backorders,
      status: Formz.validate([backorders]),
    ));
  }

  void _onDescriptionChanged(DescriptionChanged event, Emitter<ProductAddState> emit) {
    final description = Description.dirty(event.description);
    emit(state.copyWith(
      description: description,
      status: Formz.validate([description]),
    ));
  }

  void _onImageChanged(ImageChanged event, Emitter<ProductAddState> emit) {
    emit(state.copyWith(image: Image.dirty(event.image)));
  }

  void _onGalleryChanged(GalleryChanged event, Emitter<ProductAddState> emit) {
    List<ImageData> images = state.gallery.value != null ? state.gallery.value! : <ImageData>[];

    emit(state.copyWith(gallery: Gallery.dirty([...images, ...event.images])));
  }

  void _onImageDeleteGalleryChanged(ImageDeletedGalleryChanged event, Emitter<ProductAddState> emit) {
    List<ImageData> images = state.gallery.value != null ? state.gallery.value! : <ImageData>[];
    images.removeWhere((ImageData e) => e.toString() == event.image.toString());
    emit(state.copyWith(gallery: Gallery.dirty([...images])));
  }

  void _onImageDeleteChanged(ImageDeletedChanged event, Emitter<ProductAddState> emit) {
    emit(state.copyWith(image: const Image.pure()));
  }

  void _onExternalUrlChanged(ExternalUrlChanged event, Emitter<ProductAddState> emit) {
    final externalUrl = ExternalUrl.dirty(event.externalUrl);
    emit(state.copyWith(
      externalUrl: externalUrl,
      status: Formz.validate([externalUrl]),
    ));
  }

  void _onButtonTextChanged(ButtonTextChanged event, Emitter<ProductAddState> emit) {
    final buttonText = ButtonText.dirty(event.buttonText);
    emit(state.copyWith(
      buttonText: buttonText,
      status: Formz.validate([buttonText]),
    ));
  }

  void _onWeightChanged(WeightChanged event, Emitter<ProductAddState> emit) {
    valueWeight = event.weight;
  }

  void _onLengthChanged(LengthChanged event, Emitter<ProductAddState> emit) {
    valueLength = event.length;
  }

  void _onWidthChanged(WidthChanged event, Emitter<ProductAddState> emit) {
    valueWidth = event.width;
  }

  void _onHeightChanged(HeightChanged event, Emitter<ProductAddState> emit) {
    valueHeight = event.height;
  }

  void _onUpdateAttributesChanged(UpdateAttributeChanged event, Emitter<ProductAddState> emit) {
    List<AttributeData> data = [
      ...state.attributes.value,
    ];
    int visit = data.indexWhere((element) => element.key == event.attribute.key);
    if (visit > -1) {
      data[visit] = event.attribute;
      final attributes = ListAttribute.dirty(data);

      emit(state.copyWith(
        attributes: attributes,
        status: Formz.validate([attributes]),
      ));
    }
  }

  void _onAddAttributesChanged(AddAttributeChanged event, Emitter<ProductAddState> emit) {
    List<AttributeData> data = [
      ...state.attributes.value,
    ];
    data.addAll(event.attributes);

    final attributes = ListAttribute.dirty(data);
    emit(state.copyWith(
      attributes: attributes,
      status: Formz.validate([attributes]),
    ));
  }

  void _onDeleteAttributesChanged(DeleteAttributeChanged event, Emitter<ProductAddState> emit) {
    List<AttributeData> data = [
      ...state.attributes.value,
    ];
    int visit = data.indexWhere((element) => element.key == event.keyAttribute);
    if (visit > -1) {
      data.removeAt(visit);
      final attributes = ListAttribute.dirty(data);

      emit(state.copyWith(
        attributes: attributes,
        status: Formz.validate([attributes]),
      ));
    }
  }

  void _onDefaultAttributesChanged(DefaultAttributeChanged event, Emitter<ProductAddState> emit) {
    List<DefaultAttributeData> data = [
      ...state.defaultAttributes.value,
    ];
    DefaultAttributeData value = event.defaultAttribute;

    int visit = data.indexWhere((element) => element.id == value.id && element.name == element.name);

    if (visit < 0) {
      data.add(value);
    } else {
      data[visit] = value;
    }

    final defaultAttributes = ListDefaultAttribute.dirty(data);
    emit(state.copyWith(
      defaultAttributes: defaultAttributes,
      status: Formz.validate([defaultAttributes]),
    ));
  }

  void _onVariationChanged(VariationChanged event, Emitter<ProductAddState> emit) {
    List<int> data = [
      ...state.variations.value,
    ];
    if (data.contains(event.idVariation)) {
      data.remove(event.idVariation);
    } else {
      data.add(event.idVariation);
    }

    final variations = ListVariation.dirty(data);

    emit(state.copyWith(
      variations: variations,
    ));
  }

  ///
  /// Handle categories changed
  void _onCategoriesChanged(CategoriesChanged event, Emitter<ProductAddState> emit) {
    ListCategory categories = ListCategory.dirty(event.categories);
    emit(state.copyWith(
      categories: categories,
    ));
  }

  void _onCatalogVisibilityChanged(CatalogVisibilityChanged event, Emitter<ProductAddState> emit) async {
    final catalogVisibility = CatalogVisibility.dirty(event.catalogVisibility);
    emit(state.copyWith(
      catalogVisibility: catalogVisibility,
      status: Formz.validate([catalogVisibility]),
    ));
  }

  void _onGroupedProductChanged(GroupedProductChanged event, Emitter<ProductAddState> emit) {
    List<int> data = [
      ...state.groupedProducts.value,
    ];
    int id = event.idProduct;

    bool selected = data.contains(id);

    if (!selected) {
      data.add(id);
    } else {
      data.remove(id);
    }

    final groupedProducts = GroupedProduct.dirty(data);
    emit(state.copyWith(
      groupedProducts: groupedProducts,
      status: Formz.validate([groupedProducts]),
    ));
  }

  /// post Image
  Future<void> postImage() async {
    imageSrcList = images.where((e) => e['src'] != null).toList();
    for (int i = 0; i < images.length; i++) {
      try {
        if (images[i]['image_local'] != null) {
          FormData formData = FormData.fromMap({
            'file': images[i]['image_local'],
          });
          Media res = await mediaRepository.postMedia(
              requestData: RequestData(
            data: formData,
            token: token,
            query: {'app-builder-decode': true},
          ));
          imageSrcList.add({"src": res.url});
        }
      } catch (e) {
        avoidPrint("error $e");
      }
    }
  }

  /// save attribute
  Future<void> _saveAttribute(ProductAttributeSubmitted event, Emitter<ProductAddState> emit) async {
    emit(state.copyWith(statusAttribute: FormzStatus.submissionInProgress));

    Map<String, dynamic> data = {'attributes': state.attributes.value.map((AttributeData e) => e.toJson()).toList()};

    try {
      final product = await productsRepository.updateAdvancedProduct(
        idProduct: state.id,
        requestData: RequestData(
          data: data,
          query: {'app-builder-decode': true},
          cancelToken: _cancelToken,
          token: token,
        ),
      );
      List<Map<String, dynamic>>? productAttributes = product.attributes;
      List<AttributeData> attributes = <AttributeData>[];
      if (productAttributes?.isNotEmpty == true) {
        attributes = productAttributes!.map((attr) => AttributeData.fromJson(attr)).toList().cast<AttributeData>();
      }

      emit(state.copyWith(statusAttribute: FormzStatus.submissionSuccess, attributes: ListAttribute.dirty(attributes)));
    } on RequestError catch (e) {
      emit(state.copyWith(statusAttribute: FormzStatus.submissionFailure, messageAttributeError: e.message));
    }
  }

  void dataProduct() async {
    data = {
      'name': state.name.value,
      'regular_price': state.regularPrice.value,
      'sale_price': state.salePrice.value,
      'description': valueDescription,
      'sku': valueSku,
      'stock_quantity': state.managerStock.value ? valueStockQuantity : null,
      'manage_stock': state.managerStock.value,
      'catalog_visibility': state.catalogVisibility.value,
      'categories': state.categories.value.map((Category e) => {'id': e.id}).toList(),
      'attributes': state.attributes.value.map((AttributeData e) => e.toJson()).toList(),
      'images': imageSrcList,
      // 'type': state.productType.productType,
    };
  }

  Future<List<Map<String, dynamic>>> _preImages() async {
    try {
      List<Map<String, dynamic>> images = [];
      // Feature image
      if (state.image.value?.image != null && state.image.value?.image?.id != null) {
        images.add({
          'id': state.image.value!.image!.id,
          'src': state.image.value!.image?.src,
        });
      }

      if (state.image.value?.file != null && state.image.value?.file?.path != null) {
        String path = state.image.value!.file!.path;
        FormData formData = FormData.fromMap({
          'file': await MultipartFile.fromFile(
            path,
            filename: path.split('/').last,
          ),
        });

        Media image = await mediaRepository.postMedia(
            requestData: RequestData(
          data: formData,
          token: token,
          query: {'app-builder-decode': true},
        ));
        images.add({'id': image.id, 'src': image.url});
      }

      // Gallery
      List<ImageData?>? gallery = state.gallery.value;
      if (gallery != null && gallery.isNotEmpty) {
        int i = 0;
        await Future.doWhile(() async {
          ImageData? imageData = gallery[i];

          if (imageData?.image != null && imageData?.image?.id != null) {
            images.add({
              'id': imageData!.image!.id,
              'src': imageData.image?.src,
            });
          }

          if (imageData?.file != null && imageData?.file?.path != null) {
            String path = imageData!.file!.path;
            FormData formData = FormData.fromMap({
              'file': await MultipartFile.fromFile(
                path,
                filename: path.split('/').last,
              ),
            });
            Media image = await mediaRepository.postMedia(
                requestData: RequestData(
              data: formData,
              token: token,
              query: {'app-builder-decode': true},
            ));
            images.add({'id': image.id, 'src': image.url});
          }

          i++;
          return i < gallery.length;
        });
      }

      return images;
    } catch (e) {
      rethrow;
    }
  }

  void _deleteProduct(ProductDeleteSubmitted event, Emitter<ProductAddState> emit) async {
    try {
      await productsRepository.deleteProducts(
        productId: state.id,
        requestData: RequestData(
          token: token,
          query: {'app-builder-decode': true},
        ),
      );
    } on RequestError catch (_) {}
  }

  /// Handle submitted data
  void _onSubmitted(ProductAddSubmitted event, Emitter<ProductAddState> emit) async {
    final name = Name.dirty(state.name.value);
    final regularPrice = RegularPrice.dirty(type: state.type.value, value: state.regularPrice.value);
    final salePrice =
        SalePrice.dirty(type: state.type.value, regularPrice: regularPrice.value, value: state.salePrice.value);
    final stockQuantity = StockQuantity.dirty(manageStock: state.managerStock.value, value: state.stockQuantity.value);

    FormzStatus status = Formz.validate([name, regularPrice, salePrice, stockQuantity]);

    if (status.isValidated) {
      emit(state.copyWith(
        status: FormzStatus.submissionInProgress,
        enableDraft: event.status == 'draft',
      ));

      Map<String, dynamic> data = {
        ...state.toJson(),
        'status': event.status,
      };

      // Prepare images
      List<Map<String, dynamic>> images = await _preImages();
      if (images.isNotEmpty) {
        data['images'] = images;
      }

      avoidPrint('------------------------ > data');
      avoidPrint(data);
      avoidPrint('------------------------ > data');

      try {
        Product product = await productsRepository.updateProduct(
          idProduct: state.id,
          requestData: RequestData(
            data: data,
            query: {'app-builder-decode': true},
            cancelToken: _cancelToken,
            token: token,
          ),
        );
        // Feature image
        List<dynamic> productImages = product.images ?? [];
        dynamic featureImage = productImages.isNotEmpty ? productImages[0] : null;

        // Gallery
        List<ImageData> galleryImages = <ImageData>[];
        if (productImages.length > 1) {
          productImages.removeAt(0);
          galleryImages = productImages.map((e) => ImageData.fromJson(e)).toList().cast<ImageData>();
        }

        emit(state.copyWith(
          status: FormzStatus.submissionSuccess,
          changeStatus: true,
          skuParent: product.sku ?? '',
          image: featureImage != null ? Image.dirty(ImageData.fromJson(featureImage)) : const Image.pure(),
          gallery: galleryImages.isNotEmpty ? Gallery.dirty(galleryImages) : const Gallery.pure(),
        ));
      } on RequestError catch (e) {
        emit(state.copyWith(status: FormzStatus.submissionFailure, messageError: e.message));
      }
    } else {
      emit(state.copyWith(
        name: name,
        regularPrice: regularPrice,
        salePrice: salePrice,
        stockQuantity: stockQuantity,
        status: status,
      ));
    }
  }
}
