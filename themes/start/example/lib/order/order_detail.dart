import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import 'widgets/product_item.dart';

List<Option> _options = const [
  Option(key: '1', name: 'On hold'),
  Option(key: '2', name: 'Completed'),
  Option(key: '3', name: 'Processing'),
  Option(key: '4', name: 'Pending payment'),
];

class OrderDetailScreen extends StatelessWidget with AppbarMixin, OrderMixin {
  static const routeName = '/order_detail';

  const OrderDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: baseStyleAppBar(title: 'Order #0342'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(25, 8, 25, 25),
        child: OrderDetailContent(
          orderBasic: OrderDetailBasic(
            icon: buildIcon(theme: theme),
            orderId: buildId(text: '#3242', theme: theme),
            status: buildStatus(text: 'Processcing', theme: theme),
            dateTime: buildDateTimeUser(date: '29/10/2019', time: '10:00 AM', theme: theme),
          ),
          note: const Text('note'),
          billing: LabelView(
            title: 'Billing Address',
            child: OrderDetailAddress(
              name: 'Name User',
              address: '123 Khuat Duy Tien, Ha Noi, VietNam, 100000',
              email: ButtonRichText(
                subTitle: 'Email address: ',
                title: 'test@gmail.com',
                onTap: () {},
              ),
              phone: ButtonRichText(
                subTitle: 'Phone: ',
                title: '84988164483',
                onTap: () => {},
              ),
            ),
          ),
          shipping: const LabelView(
            title: 'Shipping Address',
            child: OrderDetailAddress(
              name: 'Name User',
              address: '123 Khuat Duy Tien, Ha Noi, VietNam, 100000',
            ),
          ),
          product: LabelView(
            title: 'Information Product',
            child: OrderDetailProductTotal(
              product: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 23),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (_, int index) {
                    return const ProductItem();
                  },
                  separatorBuilder: (_, int index) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 15, bottom: 10),
                      child: Divider(height: 1, thickness: 1),
                    );
                  },
                  itemCount: 2,
                ),
              ),
              total: Column(
                children: const [
                  OrderDetailTile(
                    title: 'Payment Method',
                    subtitle: 'Checkout Payments',
                    textSize: TextSize.overline,
                    titleSubColor: true,
                  ),
                  SizedBox(height: 3),
                  OrderDetailTile(
                    title: 'Subtotal',
                    subtitle: '\$ 598',
                    titleSubColor: true,
                  ),
                  OrderDetailTile(
                    title: 'Tax',
                    subtitle: '\$ 10',
                    titleSubColor: true,
                  ),
                  SizedBox(height: 8),
                  OrderDetailTile(
                    title: 'Total',
                    subtitle: '\$ 578',
                    textSize: TextSize.subtitle2,
                  ),
                ],
              ),
            ),
          ),
          status: LabelView(
            title: 'Change status order',
            child: InputSelect(value: '2', options: _options, onChanged: (_) {}),
          ),
          buttonBottom: Center(
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Save Order'),
            ),
          ),
        ),
      ),
    );
  }
}
