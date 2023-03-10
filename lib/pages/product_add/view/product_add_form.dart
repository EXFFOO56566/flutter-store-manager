import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:formz/formz.dart';
import '../bloc/product_add_bloc.dart';
import 'product_message.dart';

// Themes
import 'package:flutter_store_manager/themes.dart';
import 'package:products_repository/products_repository.dart';

// Inputs
import 'inputs/inputs.dart';

class ProductAddForm extends StatelessWidget with AppbarMixin {
  const ProductAddForm({Key? key}) : super(key: key);

  List<AttributeData> getAttributeVariation(List<AttributeData> data) {
    return data.where((element) {
      bool checkCustom = false;
      if (element.option.type == OptionDataType.custom && element.option.custom.isNotEmpty) {
        List arrCustom = element.option.custom.split('|');
        AttributeData? lastAttr = data.lastWhereOrNull(
          (e) =>
              e.name?.isNotEmpty == true &&
              e.variation == true &&
              e.id == element.id &&
              e.name == element.name &&
              e.option.custom.isNotEmpty == true,
        );
        checkCustom = lastAttr?.key == element.key && arrCustom.isNotEmpty;
      }
      return element.name?.isNotEmpty == true &&
          element.variation == true &&
          (checkCustom || (element.option.type == OptionDataType.term || element.option.term.isNotEmpty));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductAddBloc, ProductAddState>(
      buildWhen: (previous, current) =>
          previous.type != current.type ||
          previous.attributes != current.attributes ||
          previous.managerStock != current.managerStock,
      builder: (context, state) {
        List<AttributeData> attributeVariation = getAttributeVariation(state.attributes.value);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProductTypeView(),
            const ProductName(),
            const SizedBox(height: 15),
            if (ProductExternalUrl.visible.contains(state.type.value)) ...[
              const ProductExternalUrl(),
              const SizedBox(height: 15),
            ],
            if (ProductButtonText.visible.contains(state.type.value)) ...[
              const ProductButtonText(),
              const SizedBox(height: 15),
            ],
            if (Price.visible.contains(state.type.value)) ...[
              const Price(),
              const SizedBox(height: 15),
            ],
            const ProductDescription(),
            const SizedBox(height: 15),
            const ProductImage(),
            const SizedBox(height: 40),
            const ProductGallery(),
            const SizedBox(height: 40),
            ProductAttributeView(showVariation: state.type.value == 'variable'),
            if (ProductDefaultAttribute.visible.contains(state.type.value) && attributeVariation.isNotEmpty) ...[
              const SizedBox(height: 16),
              ProductDefaultAttribute(
                attributes: attributeVariation,
              ),
            ],
            if (ProductVariation.visible.contains(state.type.value)) ...[
              const SizedBox(height: 16),
              ProductVariation(
                attributes: attributeVariation,
              ),
            ],
            const SizedBox(height: 24),
            const ProductCategories(),
            const SizedBox(height: 15),
            if (ProductGroupedProduct.visible.contains(state.type.value)) ...[
              const ProductGroupedProduct(),
              const SizedBox(height: 15),
            ],
            const ProductSku(),
            const SizedBox(height: 15),
            if (ProductManagerStock.visible.contains(state.type.value)) ...[
              const ProductManagerStock(),
              const SizedBox(height: 15),
            ],
            if (state.managerStock.value) ...[
              if (ProductStockQuantity.visible.contains(state.type.value)) ...[
                const ProductStockQuantity(),
                const SizedBox(height: 15),
              ],
              if (ProductBackorders.visible.contains(state.type.value)) ...[
                const ProductBackorders(),
                const SizedBox(height: 15),
              ],
            ],
            if (ProductStockStatus.visible.contains(state.type.value) &&
                (state.type.value == 'grouped' || (state.type.value != 'grouped' && !state.managerStock.value))) ...[
              const ProductStockStatus(),
              const SizedBox(height: 15),
            ],
            if (ProductSoldIndividually.visible.contains(state.type.value)) ...[
              const ProductSoldIndividually(),
              const SizedBox(height: 15)
            ],
            const ProductVisibility(),
            const ProductMessage(),
            const SizedBox(height: 25),
            const Center(
              child: ButtonForm(),
            ),
          ],
        );
      },
    );
  }
}

class ButtonForm extends StatelessWidget with LoadingMixin {
  final String? text;
  final ButtonStyle? style;

  const ButtonForm({
    Key? key,
    this.text,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductAddBloc, ProductAddState>(
      buildWhen: (previous, current) =>
          previous.status != current.status || previous.enableDraft != current.enableDraft,
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: ElevatedColorButton.surface(
                key: const Key('product_form_draft_button'),
                onPressed: () {
                  if (!state.status.isSubmissionInProgress) {
                    context.read<ProductAddBloc>().add(const ProductAddSubmitted('draft'));
                  }
                },
                padding: EdgeInsets.zero,
                child: state.enableDraft && state.status.isSubmissionInProgress
                    ? buildLoadingElevatedSurface()
                    : Text(text ?? AppLocalizations.of(context)!.translate('common:text_draft')),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                key: const Key('product_form_publish_button'),
                onPressed: () {
                  if (!state.status.isSubmissionInProgress) {
                    context.read<ProductAddBloc>().add(const ProductAddSubmitted('publish'));
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: !state.enableDraft && state.status.isSubmissionInProgress
                    ? buildLoadingElevated()
                    : Text(text ?? AppLocalizations.of(context)!.translate('common:text_submit')),
              ),
            ),
          ],
        );
      },
    );
  }
}
