import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/variation_bloc.dart';
import 'inputs/inputs.dart';

class VariationField extends StatelessWidget {
  final bool hint;
  const VariationField({
    Key? key,
    this.hint = true,
  }) : super(key: key);

  Widget buildChild({required Widget child, double width = 300, bool isDivColumn = false}) {
    double widthChild = isDivColumn ? width / 2 - 6 : width;
    return SizedBox(
      width: widthChild,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VariationBloc, VariationState>(
      builder: (_, state) {
        return LayoutBuilder(
          builder: (_, BoxConstraints constraints) {
            double width = constraints.maxWidth;
            return Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.start,
              spacing: 0,
              runSpacing: 15,
              children: [
                buildChild(
                  width: width,
                  child: Column(
                    children: [
                      const VariationStatus(),
                      if (!hint) ...[
                        const VariationDownloadable(),
                        const VariationVirtual(),
                      ],
                      const VariationManageStock(),
                    ],
                  ),
                ),
                buildChild(
                  width: width,
                  child: const VariationImage(),
                ),
                buildChild(
                  width: width,
                  isDivColumn: true,
                  child: const VariationRegularPrice(),
                ),
                buildChild(
                  width: width,
                  isDivColumn: true,
                  child: const VariationSalePrice(),
                ),
                if (state.manageStock.value) ...[
                  buildChild(
                    width: width,
                    isDivColumn: true,
                    child: const VariationStockQuantity(),
                  ),
                  buildChild(
                    width: width,
                    isDivColumn: true,
                    child: const VariationBackorders(),
                  ),
                ],
                buildChild(
                  width: width,
                  isDivColumn: true,
                  child: const VariationSku(),
                ),
                if (!state.manageStock.value)
                  buildChild(
                    width: width,
                    isDivColumn: true,
                    child: const VariationStockStatus(),
                  ),
                if (!state.virtual.value) ...[
                  buildChild(
                    width: width,
                    isDivColumn: true,
                    child: const VariationWeight(),
                  ),
                  buildChild(
                    width: width,
                    isDivColumn: true,
                    child: const VariationLength(),
                  ),
                  buildChild(
                    width: width,
                    isDivColumn: true,
                    child: const VariationWidth(),
                  ),
                  buildChild(
                    width: width,
                    isDivColumn: true,
                    child: const VariationHeight(),
                  ),
                ],
                if (!hint) ...[
                  buildChild(
                    width: width,
                    child: const VariationShippingClass(),
                  ),
                  buildChild(
                    width: width,
                    child: const VariationTaxClass(),
                  ),
                ],
                buildChild(
                  width: width,
                  child: const VariationDescription(),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
