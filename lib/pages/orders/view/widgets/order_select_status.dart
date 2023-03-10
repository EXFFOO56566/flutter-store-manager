// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'dart:math' as math;

// Repository packages
import 'package:order_repository/order_repository.dart';

// Bloc
import 'package:flutter_store_manager/pages/order_detail/bloc/order_detail_cubit.dart';

//Themes
import 'package:flutter_store_manager/themes.dart';

// Constants
import 'package:flutter_store_manager/constants/color_block.dart';

class OrderSelectStatus extends StatelessWidget {
  final OrderData? orderData;
  final String title;
  final Color color;

  const OrderSelectStatus({
    Key? key,
    this.orderData,
    this.title = '',
    this.color = ColorBlock.orange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;
    Color colorChangedStatus = ColorBlock.orange;
    void clickSelect({
      required BuildContext context,
      required List<Option> options,
      String? key,
      bool onChangedStatus = true,
      OrderDetailCubit? cubit,
      OrderDetailState? state,
    }) async {
      await showModalBottomSheet<Option?>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          MediaQueryData mediaQuery = MediaQuery.of(context);
          return Container(
            constraints: BoxConstraints(maxHeight: mediaQuery.size.height * 0.6),
            padding: mediaQuery.viewInsets,
            child: ModalOptionSingleFooterView(
              options: options,
              value: onChangedStatus == true ? key : orderData?.status,
              onPressButton: (String? key) {
                cubit!.changeOrderStatusUI(
                  status: OrderDetailState.mapOrderStatus(key: key),
                  onChangedStatus: true,
                );
                if (state!.buttonState is! LoadingState) {
                  Navigator.pop(context, options.firstWhere((element) => element.key == key));
                  cubit.updateOrderStatus(context, ConvertData.stringToInt(orderData!.id!));
                }
              },
              isExpand: false,
              isSearch: false,
              textButtonBottom: translate('order:text_button_save'),
            ),
          );
        },
      );
    }

    return BlocBuilder<OrderDetailCubit, OrderDetailState>(
      builder: (context, state) {
        List<Option> options = [
          Option(
            key: OrderDetailState.mapOrderStatus(key: OrderDetailStatus.pending),
            name: translate('order:text_pending'),
          ),
          Option(
            key: OrderDetailState.mapOrderStatus(key: OrderDetailStatus.processing),
            name: translate('order:text_processing'),
          ),
          Option(
            key: OrderDetailState.mapOrderStatus(key: OrderDetailStatus.onHold),
            name: translate('order:text_on_hold'),
          ),
          Option(
            key: OrderDetailState.mapOrderStatus(key: OrderDetailStatus.completed),
            name: translate('order:text_completed'),
          ),
        ];
        String keyStatus = OrderDetailState.mapOrderStatus(key: state.orderStatus);
        switch (keyStatus) {
          case 'completed':
            colorChangedStatus = ColorBlock.green;
            break;
          case 'processing':
            colorChangedStatus = theme.primaryColor;
            break;
          case 'on-hold':
            colorChangedStatus = ColorBlock.redError;
            break;
          case 'pending':
            colorChangedStatus = ColorBlock.redError;
            break;
          default:
            colorChangedStatus = Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
            break;
        }
        String name = options[options.indexWhere((e) => e.key == keyStatus)].name;
        return InkWell(
          onTap: () {
            clickSelect(
              context: context,
              options: options,
              onChangedStatus: state.onChangedStatus,
              key: state.onChangedStatus ? keyStatus : orderData?.status,
              cubit: context.read<OrderDetailCubit>(),
              state: state,
            );
          },
          child: Badge(
            title: state.onChangedStatus == true ? name : title,
            background: state.onChangedStatus == true ? colorChangedStatus : color,
            padHorizontal: 12,
            iconRight: CommunityMaterialIcons.chevron_down,
            sizeIcon: 18,
          ),
        );
      },
    );
  }
}
