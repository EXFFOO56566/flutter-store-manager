import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_store_manager/common/widgets/image/image.dart';
import 'package:flutter_store_manager/mixins/utility_mixin.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:formz/formz.dart';
import 'package:media_repository/media_repository.dart';
import 'package:products_repository/products_repository.dart';

import '../../default_attribute/default_attribute.dart';
import '../model/models.dart';

part 'variation_event.dart';

part 'variation_state.dart';

class VariationBloc extends Bloc<VariationEvent, VariationState> {
  final ProductsRepository productsRepository;
  final MediaRepository mediaRepository;
  final String token;
  final int idProduct;
  final String skuParent;

  final Map<String, dynamic> data;

  VariationBloc({
    required this.productsRepository,
    required this.mediaRepository,
    required this.token,
    required this.idProduct,
    required this.data,
    required this.skuParent,
  }) : super(VariationState.fromJson(data, skuParent)) {
    on<AttributeChanged>(_onAttributeChanged);
    on<StatusTypeChanged>(_onStatusTypeChanged);
    on<DownloadableChanged>(_onDownloadableChanged);
    on<VirtualChanged>(_onVirtualChanged);
    on<ManageStockChanged>(_onManageStockChanged);
    on<RegularPriceChanged>(_onRegularPriceChanged);
    on<SalePriceChanged>(_onSalePriceChanged);
    on<ImageChanged>(_onImageChanged);
    on<StockQuantityChanged>(_onStockQuantityChanged);
    on<BackordersChanged>(_onBackordersChanged);
    on<SkuChanged>(_onSkuChanged);
    on<StockStatusChanged>(_onStockStatusChanged);
    on<WeightChanged>(_onWeightChanged);
    on<LengthChanged>(_onLengthChanged);
    on<HeightChanged>(_onHeightChanged);
    on<WidthChanged>(_onWidthChanged);
    on<ShippingClassChanged>(_onShippingClassChanged);
    on<TaxClassChanged>(_onTaxClassChanged);
    on<DescriptionChanged>(_onDescriptionChanged);
    on<VariationUpdateSubmitted>(_onUpdateSubmitted);
    on<VariationAddSubmitted>(_onAddSubmitted);
  }

  void _onAttributeChanged(AttributeChanged event, Emitter<VariationState> emit) async {
    List<DefaultAttributeData> data = [
      ...state.attributes.value,
    ];
    DefaultAttributeData value = event.attribute;

    int visit = data.indexWhere((element) => element.id == value.id && element.name == element.name);

    if (visit < 0) {
      data.add(value);
    } else {
      data[visit] = value;
    }

    final attributes = ListAttribute.dirty(data);
    emit(state.copyWith(
      attributes: attributes,
      status: Formz.validate([attributes]),
    ));
  }

  void _onStatusTypeChanged(StatusTypeChanged event, Emitter<VariationState> emit) async {
    final statusType = Status.dirty(event.type);
    emit(state.copyWith(
      statusType: statusType,
      status: Formz.validate([statusType]),
    ));
  }

  void _onDownloadableChanged(DownloadableChanged event, Emitter<VariationState> emit) async {
    final downloadable = Downloadable.dirty(event.value);
    emit(state.copyWith(
      downloadable: downloadable,
      status: Formz.validate([downloadable]),
    ));
  }

  void _onVirtualChanged(VirtualChanged event, Emitter<VariationState> emit) async {
    final virtual = Virtual.dirty(event.value);
    emit(state.copyWith(
      virtual: virtual,
      status: Formz.validate([virtual]),
    ));
  }

  void _onManageStockChanged(ManageStockChanged event, Emitter<VariationState> emit) async {
    final manageStock = ManageStock.dirty(event.value);
    final stockQuantity = StockQuantity.dirty(manageStock: event.value, value: state.stockQuantity.value);
    emit(state.copyWith(
      manageStock: manageStock,
      stockQuantity: stockQuantity,
      status: Formz.validate([manageStock, stockQuantity]),
    ));
  }

  void _onRegularPriceChanged(RegularPriceChanged event, Emitter<VariationState> emit) async {
    final regularPrice = RegularPrice.dirty(event.regularPrice);
    final salePrice = SalePrice.dirty(
      regularPrice: event.regularPrice,
      value: state.salePrice.value,
    );
    emit(state.copyWith(
      regularPrice: regularPrice,
      salePrice: salePrice,
      status: Formz.validate([regularPrice, salePrice]),
    ));
  }

  void _onSalePriceChanged(SalePriceChanged event, Emitter<VariationState> emit) async {
    final salePrice = SalePrice.dirty(regularPrice: state.regularPrice.value, value: event.salePrice);
    emit(state.copyWith(
      salePrice: salePrice,
      status: Formz.validate([salePrice]),
    ));
  }

  void _onImageChanged(ImageChanged event, Emitter<VariationState> emit) async {
    final image = Image.dirty(event.image);
    emit(state.copyWith(
      image: image,
      status: Formz.validate([image]),
    ));
  }

  void _onStockQuantityChanged(StockQuantityChanged event, Emitter<VariationState> emit) async {
    final stockQuantity = StockQuantity.dirty(manageStock: state.manageStock.value, value: event.stockQuantity);
    emit(state.copyWith(
      stockQuantity: stockQuantity,
      status: Formz.validate([stockQuantity]),
    ));
  }

  void _onBackordersChanged(BackordersChanged event, Emitter<VariationState> emit) async {
    final backorders = Backorders.dirty(event.backorders);
    emit(state.copyWith(
      backorders: backorders,
      status: Formz.validate([backorders]),
    ));
  }

  void _onSkuChanged(SkuChanged event, Emitter<VariationState> emit) async {
    final sku = Sku.dirty(event.sku);
    emit(state.copyWith(
      sku: sku,
      status: Formz.validate([sku]),
    ));
  }

  void _onStockStatusChanged(StockStatusChanged event, Emitter<VariationState> emit) async {
    final stockStatus = StockStatus.dirty(event.stockStatus);
    emit(state.copyWith(
      stockStatus: stockStatus,
      status: Formz.validate([stockStatus]),
    ));
  }

  void _onWeightChanged(WeightChanged event, Emitter<VariationState> emit) async {
    final weight = Weight.dirty(event.weight);
    emit(state.copyWith(
      weight: weight,
      status: Formz.validate([weight]),
    ));
  }

  void _onLengthChanged(LengthChanged event, Emitter<VariationState> emit) async {
    final length = Length.dirty(event.length);
    emit(state.copyWith(
      length: length,
      status: Formz.validate([length]),
    ));
  }

  void _onWidthChanged(WidthChanged event, Emitter<VariationState> emit) async {
    final width = Width.dirty(event.width);
    emit(state.copyWith(
      width: width,
      status: Formz.validate([width]),
    ));
  }

  void _onHeightChanged(HeightChanged event, Emitter<VariationState> emit) async {
    final height = Height.dirty(event.height);
    emit(state.copyWith(
      height: height,
      status: Formz.validate([height]),
    ));
  }

  void _onShippingClassChanged(ShippingClassChanged event, Emitter<VariationState> emit) async {
    final shippingClass = ShippingClass.dirty(event.shippingClass);
    emit(state.copyWith(
      shippingClass: shippingClass,
      status: Formz.validate([shippingClass]),
    ));
  }

  void _onTaxClassChanged(TaxClassChanged event, Emitter<VariationState> emit) async {
    final taxClass = TaxClass.dirty(event.taxClass);
    emit(state.copyWith(
      taxClass: taxClass,
      status: Formz.validate([taxClass]),
    ));
  }

  void _onDescriptionChanged(DescriptionChanged event, Emitter<VariationState> emit) async {
    final description = Description.dirty(event.description);
    emit(state.copyWith(
      description: description,
      status: Formz.validate([description]),
    ));
  }

  Future<Map<String, dynamic>?> _preImage() async {
    try {
      Map<String, dynamic>? image;
      // Feature image
      if (state.image.value?.image != null && state.image.value?.image?.id != null) {
        image = {
          'id': state.image.value!.image!.id,
          'src': state.image.value!.image?.src,
        };
      }

      if (state.image.value?.file != null && state.image.value?.file?.path != null) {
        String path = state.image.value!.file!.path;
        FormData formData = FormData.fromMap({
          'file': await MultipartFile.fromFile(
            path,
            filename: path.split('/').last,
          ),
        });
        Media imageUpload = await mediaRepository.postMedia(
            requestData: RequestData(
          data: formData,
          token: token,
          query: {'app-builder-decode': true},
        ));
        image = {'id': imageUpload.id, 'src': imageUpload.url};
      }

      return image;
    } catch (e) {
      rethrow;
    }
  }

  /// Handle update submitted data
  void _onUpdateSubmitted(VariationUpdateSubmitted event, Emitter<VariationState> emit) async {
    final regularPrice = RegularPrice.dirty(state.regularPrice.value);
    final salePrice = SalePrice.dirty(regularPrice: regularPrice.value, value: state.salePrice.value);
    final height = Height.dirty(state.height.value);
    final width = Width.dirty(state.width.value);
    final length = Length.dirty(state.length.value);
    final weight = Weight.dirty(state.weight.value);
    final stockQuantity = StockQuantity.dirty(manageStock: state.manageStock.value, value: state.stockQuantity.value);

    FormzStatus status = Formz.validate([
      regularPrice,
      salePrice,
      height,
      width,
      length,
      weight,
      stockQuantity,
    ]);

    if (status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      Map<String, dynamic> data = state.toJson();

      // Prepare image
      Map<String, dynamic>? image = await _preImage();
      if (image != null) {
        data['image'] = image;
      }
      if (data.containsKey('id')) {
        data.remove('id');
      }
      try {
        await productsRepository.updateVariation(
          idProduct: idProduct,
          idVariation: state.id!,
          requestData: RequestData(
            data: data,
            query: {'app-builder-decode': true},
            token: token,
          ),
        );

        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } on RequestError catch (e) {
        emit(
          state.copyWith(
            status: FormzStatus.submissionFailure,
            errorMessage: e.message,
          ),
        );
      }
    } else {
      emit(state.copyWith(
        regularPrice: regularPrice,
        salePrice: salePrice,
        height: height,
        width: width,
        length: length,
        weight: weight,
        stockQuantity: stockQuantity,
        status: status,
      ));
    }
  }

  /// Handle add submitted data
  void _onAddSubmitted(VariationAddSubmitted event, Emitter<VariationState> emit) async {
    final regularPrice = RegularPrice.dirty(state.regularPrice.value);
    final salePrice = SalePrice.dirty(regularPrice: regularPrice.value, value: state.salePrice.value);
    final height = Height.dirty(state.height.value);
    final width = Width.dirty(state.width.value);
    final length = Length.dirty(state.length.value);
    final weight = Weight.dirty(state.weight.value);
    final stockQuantity = StockQuantity.dirty(manageStock: state.manageStock.value, value: state.stockQuantity.value);

    FormzStatus status = Formz.validate([
      regularPrice,
      salePrice,
      height,
      width,
      length,
      weight,
      stockQuantity,
    ]);

    if (status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      Map<String, dynamic> data = state.toJson();

      // Prepare image
      Map<String, dynamic>? image = await _preImage();
      if (image != null) {
        data['image'] = image;
      }
      if (data.containsKey('id')) {
        data.remove('id');
      }
      try {
        final result = await productsRepository.addVariation(
          idProduct: idProduct,
          requestData: RequestData(
            data: data,
            query: {'app-builder-decode': true},
            token: token,
          ),
        );

        emit(
            state.copyWith(id: ConvertData.stringToInt(get(result, ['id'], 0)), status: FormzStatus.submissionSuccess));
      } on RequestError catch (e) {
        emit(
          state.copyWith(
            status: FormzStatus.submissionFailure,
            errorMessage: e.message,
          ),
        );
      }
    } else {
      emit(state.copyWith(
        regularPrice: regularPrice,
        salePrice: salePrice,
        height: height,
        width: width,
        length: length,
        weight: weight,
        stockQuantity: stockQuantity,
        status: status,
      ));
    }
  }
}
