// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'package:flutter_store_manager/utils/currency_format.dart' as currency_format;

// Repository packages
import 'package:order_repository/order_repository.dart';

// Bloc
import 'package:flutter_store_manager/pages/order_detail/bloc/order_detail_cubit.dart';

// View
import 'package:flutter_store_manager/pages/order_detail/view/order_note/view/order_note_view.dart';
import 'package:flutter_store_manager/pages/orders/view/widgets/order_item_date_time.dart';
import 'package:flutter_store_manager/pages/orders/view/widgets/order_item_status.dart';
import 'package:url_launcher/url_launcher.dart';
import 'order_appbar_leading.dart';
import 'order_detail_product.dart';

//Themes
import 'package:flutter_store_manager/themes.dart';

class OrderDetailBody extends StatefulWidget {
  final Map orderData;
  const OrderDetailBody({Key? key, required this.orderData}) : super(key: key);

  @override
  OrderDetailBodyState createState() => OrderDetailBodyState();
}

class OrderDetailBodyState extends State<OrderDetailBody> with AppbarMixin, OrderMixin, LoadingMixin {
  late OrderDetailCubit cubit;
  OrderData? _order;

  @override
  void initState() {
    super.initState();
    cubit = context.read<OrderDetailCubit>();
    OrderData? data = widget.orderData['orderDetail'] is OrderData && widget.orderData['orderDetail'].id != null
        ? widget.orderData['orderDetail']
        : null;
    if (data != null) {
      setState(() {
        _order = data;
      });
    } else {
      int id = ConvertData.stringToInt(widget.orderData['id']);
      if (id > 0) {
        cubit.getOrderDetail(orderId: widget.orderData['id']);
      }
    }
  }

  Future<void> _makePhoneCall(String? phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> _makeEmail(String? email) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;

    return BlocConsumer<OrderDetailCubit, OrderDetailState>(
      buildWhen: (previous, current) => (previous.orderDetail != current.orderDetail),
      builder: (context, state) {
        late Widget child;
        if (state.actionState is LoadingState) {
          child = Center(child: buildLoading());
        } else if (state.actionState is ErrorState) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(translate('text_get_error'))));
          child = const SizedBox.shrink();
        } else {
          int id = ConvertData.stringToInt(widget.orderData['id']);
          if (id > 0) {
            _order = state.orderDetail;
          }
          if (state.onChangedStatus == false) {
            cubit.currentStatus = OrderDetailState.mapOrderStatus(key: _order!.status);
          }
          child = SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(25, 8, 25, 25),
            child: OrderDetailContent(
              orderBasic: OrderDetailBasic(
                icon: buildIcon(theme: theme),
                orderId: buildId(text: '#${_order?.id ?? _order!.id}', theme: theme),
                status: OrderItemStatus(
                  orderData: _order,
                  isStatus: true,
                ),
                dateTime: OrderItemDateTime(
                  orderData: _order,
                ),
              ),
              billing: _buildBillingAddress(order: _order, translate: translate),
              shipping: _buildShippingAddress(order: _order, translate: translate),
              product: _buildInformationProduct(order: _order, translate: translate),
              note: OrderNoteView(orderId: _order!.id ?? 0),
              status: _buildChangeStatusOrder(translate),
              buttonBottom: _buildButtonChangeStatus(translate, _order?.id ?? 0),
            ),
          );
        }
        return Scaffold(
          appBar: baseStyleAppBar(
            leadingWidget: const OrderAppbarLeading(),
            title: translate('order:text_order', {'number': (state.orderDetail?.id ?? _order!.id).toString()}),
          ),
          body: child,
        );
      },
      listenWhen: (previous, current) => previous.updateOrderStatus != current.updateOrderStatus,
      listener: (context, state) {
        switch (state.updateOrderStatus) {
          case UpdateOrderStatus.notChange:
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(translate('order:text_order_not_change'))));
            break;
          case UpdateOrderStatus.success:
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(translate('order:text_save_order_success'))));
            break;
          case UpdateOrderStatus.failure:
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(translate('order:text_save_order_error'))));
            break;
          default:
            break;
        }
      },
    );
  }

  _buildBillingAddress({OrderData? order, required TranslateType translate}) {
    return LabelView(
      title: translate('order:text_billing_address'),
      child: OrderDetailAddress(
        name: "${order?.billing?.firstName} ${order?.billing?.lastName}",
        company: "${order?.billing?.company}",
        address:
            "${order?.billing?.address1} ${order?.billing?.state}, ${order?.billing?.city}, ${order?.billing?.country} ${order?.billing?.postcode}",
        email: ButtonRichText(
          subTitle: translate('order:text_email'),
          title: order?.billing?.email ?? "",
          onTap: () => _makeEmail(order?.billing?.email.toString()),
        ),
        phone: ButtonRichText(
          subTitle: translate('order:text_phone'),
          title: order?.billing?.phone ?? "",
          onTap: () => _makePhoneCall(order?.billing?.phone),
        ),
      ),
    );
  }

  _buildShippingAddress({OrderData? order, required TranslateType translate}) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    return LabelView(
      title: translate('order:text_shipping_address'),
      child: OrderDetailAddress(
        name: "${order?.shipping?.firstName} ${order?.shipping?.lastName}",
        company: "${order?.billing?.company}",
        address:
            "${order?.shipping?.address1} ${order?.shipping?.state}, ${order?.shipping?.city}, ${order?.shipping?.country} ${order?.shipping?.postcode}",
        customerNote: order?.customerNote != ''
            ? RichText(
                text: TextSpan(
                  text: translate('order:text_customer_provided_note'),
                  style: textTheme.bodyText2,
                  children: <TextSpan>[
                    TextSpan(text: '${order?.customerNote}', style: textTheme.caption),
                  ],
                ),
              )
            : null,
      ),
    );
  }

  _buildInformationProduct({OrderData? order, required TranslateType translate}) {
    if (order?.lineItems != null) {
      double adminFree = ConvertData.stringToDouble(order?.vendorOrderDetails!.itemTotal) / 10;
      double grossTotal = ConvertData.stringToDouble(order?.vendorOrderDetails!.totalCommission) + adminFree;
      return LabelView(
        title: translate('order:text_information_product'),
        child: OrderDetailProductTotal(
          product: order?.lineItems?.isNotEmpty == true
              ? Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (_, int index) {
                      return OrderDetailProduct(item: order!.lineItems![index], currency: order.currency);
                    },
                    separatorBuilder: (_, int index) {
                      return const SizedBox(height: 16);
                    },
                    itemCount: order!.lineItems!.length,
                  ),
                )
              : Container(),
          total: Column(
            children: [
              OrderDetailTile(
                title: translate('order:text_payment_method'),
                subtitle: order?.paymentMethodTitle ?? "",
                textSize: TextSize.overline,
                titleSubColor: true,
              ),
              const SizedBox(height: 4),
              OrderDetailTile(
                title: translate('order:text_subtotal'),
                subtitle: formatPrice(countSubtotal(order).toString(), order?.currency),
                titleSubColor: true,
              ),
              const SizedBox(height: 4),
              OrderDetailTile(
                title: translate('order:text_tax'),
                subtitle: formatPrice(order!.totalTax.toString(), order.currency),
                titleSubColor: true,
              ),
              const SizedBox(height: 4),
              OrderDetailTile(
                title: translate('order:text_shipping'),
                subtitle: formatPrice('${order.vendorOrderDetails!.shipping}', order.currency),
                titleSubColor: true,
              ),
              const SizedBox(height: 4),
              OrderDetailTile(
                title: translate('order:text_shipping_tax'),
                subtitle: formatPrice('${order.vendorOrderDetails!.tax}', order.currency),
                titleSubColor: true,
              ),
              if (order.vendorOrderDetails!.discountAmount != '0') ...[
                const SizedBox(height: 4),
                OrderDetailTile(
                  title: translate('order:text_discount'),
                  subtitle: formatPrice('${order.vendorOrderDetails!.discountAmount}', order.currency),
                  titleSubColor: true,
                ),
              ],
              const SizedBox(height: 4),
              OrderDetailTile(
                title: translate('order:text_gross_total'),
                subtitle: formatPrice('$grossTotal', order.currency),
                titleSubColor: true,
              ),
              const SizedBox(height: 4),
              OrderDetailTile(
                title: translate('order:text_total_earning'),
                subtitle: formatPrice('${order.vendorOrderDetails!.totalCommission}', order.currency),
                textSize: TextSize.subtitle2,
              ),
              const SizedBox(height: 4),
              OrderDetailTile(
                title: translate('order:text_admin_free'),
                subtitle: formatPrice('$adminFree', order.currency),
                titleSubColor: true,
              ),
            ],
          ),
        ),
      );
    }
    return LabelInput(
      title: translate('order:text_information_product'),
      isLarge: true,
      padding: EdgeInsets.zero,
    );
  }

  _buildChangeStatusOrder(TranslateType translateType) {
    return BlocBuilder<OrderDetailCubit, OrderDetailState>(
      builder: (context, state) {
        List<Option> options = [
          Option(
            key: OrderDetailState.mapOrderStatus(key: OrderDetailStatus.pending),
            name: translateType('order:text_pending'),
          ),
          Option(
            key: OrderDetailState.mapOrderStatus(key: OrderDetailStatus.processing),
            name: translateType('order:text_processing'),
          ),
          Option(
            key: OrderDetailState.mapOrderStatus(key: OrderDetailStatus.onHold),
            name: translateType('order:text_on_hold'),
          ),
          Option(
            key: OrderDetailState.mapOrderStatus(key: OrderDetailStatus.completed),
            name: translateType('order:text_completed'),
          ),
        ];
        return LabelView(
          title: translateType('order:text_change_status'),
          child: InputSelect(
            value: state.onChangedStatus == true
                ? OrderDetailState.mapOrderStatus(key: state.orderStatus)
                : _order?.status,
            options: options,
            onChanged: (String key) {
              cubit.changeOrderStatusUI(
                status: OrderDetailState.mapOrderStatus(key: key),
                onChangedStatus: true,
              );
            },
          ),
        );
      },
    );
  }

  _buildButtonChangeStatus(TranslateType translate, int orderId) {
    return Center(
      child: BlocBuilder<OrderDetailCubit, OrderDetailState>(
        buildWhen: (previous, current) => (previous.buttonState != current.buttonState),
        builder: (context, state) {
          return SizedBox(
            width: 161,
            child: ElevatedButton(
              onPressed: () {
                if (state.buttonState is! LoadingState) {
                  cubit.updateOrderStatus(context, orderId);
                }
              },
              style: ElevatedButton.styleFrom(padding: EdgeInsets.zero),
              child: state.buttonState is LoadingState
                  ? buildLoadingElevated()
                  : Text(translate('order:text_button_save')),
            ),
          );
        },
      ),
    );
  }

  double countSubtotal([OrderData? order]) {
    double subtotal = 0;
    if (order?.lineItems != null) {
      for (LineItems item in order!.lineItems!) {
        subtotal += ConvertData.stringToDouble(item.subtotal);
      }
    }
    return subtotal;
  }

  String formatPrice(String price, String? currency) {
    return currency_format.formatCurrency(
      price: price,
      symbol: currency_format.getSymbol(currency ?? "USD"),
      decimalDigits: 2,
      context: context,
    );
  }

  @override
  void dispose() {
    super.dispose();
    cubit.close();
  }
}
