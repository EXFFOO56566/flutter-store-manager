// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';
import 'package:flutter_store_manager/common/widgets/base_smart_fresher.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_store_manager/types/types.dart';

// Repository packages
import 'package:order_repository/order_repository.dart';

// Bloc
import '../../bloc/order_cubit.dart';

// View
import 'package:flutter_store_manager/pages/order_detail/order_detail.dart';
import 'order_item.dart';

//Themes
import 'package:flutter_store_manager/themes.dart';

class OrderBody extends StatefulWidget {
  const OrderBody({Key? key}) : super(key: key);

  @override
  OrderBodyState createState() => OrderBodyState();
}

class OrderBodyState extends State<OrderBody> with SnackMixin {
  late OrderCubit cubit;
  var keywordStream = PublishSubject<String>();

  @override
  void initState() {
    super.initState();
    cubit = context.read<OrderCubit>();
    cubit.resetState();
    cubit.getOrders(btnDone: false);
  }

  void clickFilter(BuildContext context, [String? valueSelected]) async {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    final List<Option> filters = [
      Option(key: '', name: translate('order:text_all_order')),
      Option(key: 'completed', name: translate('order:text_completed')),
      Option(key: 'pending', name: translate('order:text_pending')),
      Option(key: 'processing', name: translate('order:text_processing')),
      Option(key: 'on-hold', name: translate('order:text_on_hold')),
      Option(key: 'cancelled', name: translate('order:text_cancelled')),
      Option(key: 'refunded', name: translate('order:text_refunded')),
    ];
    String? value = await showModalBottomSheet<String?>(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        MediaQueryData mediaQuery = MediaQuery.of(context);
        return Container(
          constraints: BoxConstraints(maxHeight: mediaQuery.size.height * 0.8),
          child: ModalOptionApply(
            options: filters,
            value: valueSelected,
            onChanged: (String? text) => Navigator.pop(context, text),
            textButton: translate('common:text_apply'),
          ),
        );
      },
    );
    if (value != null) {
      cubit.filterOrder(filter: value);
    }
  }

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    return BlocConsumer<OrderCubit, OrderState>(listener: (context, state) {
      if (state.actionState is ErrorState) {
        String message = (state.actionState as ErrorState).data;
        showError(context, message);
      }
    }, builder: (context, state) {
      final canLoadMore = cubit.canLoadMore;
      final emptyData = state.actionState is! LoadingState && state.orders.isEmpty;
      final emptyFilter = emptyData && state.filter == '';
      final emptySearch = emptyData && state.keyword == '';

      return OrderListContainer(
        title: translate('order:text_orders'),
        filter: !emptyFilter
            ? IconButton(
                icon: const Icon(CommunityMaterialIcons.tune),
                iconSize: 20,
                onPressed: () => clickFilter(context, state.filter),
              )
            : null,
        child: Column(
          children: [
            if (!emptySearch)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: InputSearchField(
                  hintText: translate('order:text_search'),
                  onChanged: (value) {
                    if (value == '') {
                      cubit.getOrders(keyword: '', btnDone: true);
                    }
                  },
                  onFieldSubmitted: (value) {
                    if (value != '') {
                      cubit.getOrders(keyword: value, btnDone: true);
                    }
                  },
                ),
              ),
            Expanded(
              child: emptyData
                  ? NotificationEmptyView(
                      icon: CommunityMaterialIcons.receipt,
                      title: translate('order:text_empty'),
                    )
                  : BaseSmartFresher(
                      onRefresh: _refresh,
                      onLoadMore: canLoadMore ? _loadMore : null,
                      child: _body(state),
                    ),
            ),
          ],
        ),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    keywordStream.close();
    cubit.close();
  }

  Widget _body(OrderState state) {
    List<OrderData> emptyProducts = List.generate(10, (index) => OrderData()).toList();
    List<OrderData> data = (state.orders.isEmpty) ? emptyProducts : state.orders;

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      itemCount: data.length,
      itemBuilder: (context, index) {
        OrderData? item = data[int.parse(index.toString())];
        return OrderItem(
          onTap: () {
            if (item.id != null) {
              Navigator.of(context)
                  .pushNamed(OrdersDetailPage.routeName, arguments: {'orderDetail': item}).then((value) {
                if (value == true) {
                  cubit.getOrders();
                }
              });
            }
          },
          orderData: item,
          padding: const EdgeInsets.only(top: 17, bottom: 15),
        );
      },
    );
  }

  Future _loadMore() async {
    await cubit.loadMore();
  }

  Future _refresh() async {
    await cubit.refresh();
  }
}
