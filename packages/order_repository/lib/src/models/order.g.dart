// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderData _$OrderDataFromJson(Map<String, dynamic> json) => OrderData(
      id: ConvertData.stringToInt(json['id']),
      parentId: ConvertData.stringToInt(json['parent_id']),
      status: json['status'].toString(),
      dateCreated: json['date_created'].toString(),
      totalTax: json['total_tax'].toString(),
      cartTax: json['cart_tax'].toString(),
      shippingTotal: json['shipping_total'].toString(),
      shippingTax: json['shipping_tax'].toString(),
      discountTax: json['discount_tax'].toString(),
      discountTotal: json['discount_total'].toString(),
      total: json['total'].toString(),
      currencySymbol: json['currency_symbol'].toString(),
      currency: json['currency'].toString(),
      paymentMethodTitle: json['payment_method_title'].toString(),
      customerNote: json['customer_note'].toString(),
    )
      ..lineItems =
          (json['line_items'] as List<dynamic>?)?.map((e) => LineItems.fromJson(e as Map<String, dynamic>)).toList()
      ..shippingLines = (json['shipping_lines'] as List<dynamic>?)
          ?.map((e) => ShippingLines.fromJson(e as Map<String, dynamic>))
          .toList()
      ..billing = json['billing'] == null ? null : Billing.fromJson(json['billing'] as Map<String, dynamic>)
      ..shipping = json['shipping'] == null ? null : Shipping.fromJson(json['shipping'] as Map<String, dynamic>)
      ..vendorOrderDetails = json['vendor_order_details'] == null
          ? null
          : VendorOrderDetails.fromJson(json['vendor_order_details'] as Map<String, dynamic>);

ShippingLines _$ShippingLinesFromJson(Map<String, dynamic> json) => ShippingLines(
      methodTitle: json['method_title'].toString(),
      total: json['total'].toString(),
    )..totalTax = json['total_tax'].toString();

LineItems _$LineItemsFromJson(Map<String, dynamic> json) => LineItems(
      name: json['name'].toString(),
      quantity: ConvertData.stringToInt(json['quantity']),
      price: LineItems._toDouble(json['price']),
      subtotal: json['subtotal'].toString(),
      total: json['total'].toString(),
      metaData: (json['meta_data'] as List<dynamic>?)?.map((e) => e as Map<String, dynamic>).toList(),
      sku: json['sku'].toString(),
      productId: ConvertData.stringToInt(json['product_id']),
      storeName: json['store_name'].toString(),
      commissionValue: LineItems._toDouble(json['commission_value']),
      imageUrl: LineItems._imageUrlFromJson(json['image_url']),
    );

Billing _$BillingFromJson(Map<String, dynamic> json) => Billing(
      firstName: json['first_name'].toString(),
      lastName: json['last_name'].toString(),
      company: json['company'].toString(),
      address1: json['address_1'].toString(),
      address2: json['address_2'].toString(),
      city: json['city'].toString(),
      state: json['state'].toString(),
      postcode: json['postcode'].toString(),
      country: json['country'].toString(),
      email: json['email'].toString(),
      phone: json['phone'].toString(),
    );

Shipping _$ShippingFromJson(Map<String, dynamic> json) => Shipping(
      firstName: json['first_name'].toString(),
      lastName: json['last_name'].toString(),
      company: json['company'].toString(),
      address1: json['address_1'].toString(),
      address2: json['address_2'].toString(),
      city: json['city'].toString(),
      state: json['state'].toString(),
      postcode: json['postcode'].toString(),
      country: json['country'].toString(),
    );

VendorOrderDetails _$VendorOrderDetailsFromJson(Map<String, dynamic> json) => VendorOrderDetails(
      itemSubTotal: json['item_sub_total'].toString(),
      itemTotal: json['item_total'].toString(),
      shipping: json['shipping'].toString(),
      tax: json['tax'].toString(),
      discountAmount: json['discount_amount'].toString(),
      totalCommission: json['total_commission'].toString(),
    );
