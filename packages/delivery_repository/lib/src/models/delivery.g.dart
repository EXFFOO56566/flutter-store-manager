part of 'delivery.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Delivery _$DeliveryFromJson(Map<String, dynamic> json) => Delivery(
      id: Delivery._toInt(json['delivery_id']),
      orderID: Delivery._toInt(json['order_id']),
      nameProduct: Delivery._toNameProduct(json['item']),
      paymentRemaining: json['payment_remaining'] as String?,
      paymentMethod: json['payment_method'] as String?,
      status: json['delivery_status'] as String?,
      currency: json['currency'] as String?,
      deliveredOn: json['delivered_on'] as String?,
      customer: Delivery._toCustomer(json['customer']),
      shippingAddress: Delivery._toShippingAddress(json['shipping_address']),
      store: Delivery._toStoreInfo(json['store']),
    );
