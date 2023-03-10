// Packages & Dependencies or Helper function
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

import 'customer.dart';
import 'shipping_address.dart';
import 'store.dart';

part 'delivery.g.dart';

@JsonSerializable(createToJson: false)
class Delivery {
  @JsonKey(name: 'delivery_id', fromJson: _toInt)
  int? id;

  @JsonKey(name: 'order_id', fromJson: _toInt)
  int? orderID;

  @JsonKey(name: 'payment_remaining')
  String? paymentRemaining;

  @JsonKey(name: 'item', fromJson: _toNameProduct)
  String? nameProduct;

  @JsonKey(name: 'payment_method')
  String? paymentMethod;

  @JsonKey(name: 'delivery_status')
  String? status;

  String? currency;

  @JsonKey(name: 'delivered_on')
  String? deliveredOn;

  @JsonKey(fromJson: _toCustomer)
  CustomerDelivery? customer;

  @JsonKey(name: 'shipping_address', fromJson: _toShippingAddress)
  ShippingAddress? shippingAddress;

  @JsonKey(fromJson: _toStoreInfo)
  StoreInfo? store;

  Delivery({
    this.id,
    this.orderID,
    this.paymentRemaining,
    this.paymentMethod,
    this.nameProduct,
    this.status,
    this.currency,
    this.deliveredOn,
    this.customer,
    this.shippingAddress,
    this.store,
  });

  factory Delivery.fromJson(Map<String, dynamic> json) => _$DeliveryFromJson(json);

  static int _toInt(dynamic value) {
    return ConvertData.stringToInt(value, 0);
  }

  static String _toNameProduct(dynamic value) {
    if (value is Map && value['name'] is String) {
      return value['name'];
    }
    return '';
  }

  static CustomerDelivery _toCustomer(dynamic value) {
    return CustomerDelivery.fromJson(value ?? {});
  }

  static ShippingAddress _toShippingAddress(dynamic value) {
    return ShippingAddress.fromJson(value ?? {});
  }

  static StoreInfo _toStoreInfo(dynamic value) {
    return StoreInfo.fromJson(value ?? {});
  }
}
