import 'package:appcheap_flutter_core/utils/convert_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable(createToJson: false)
class OrderData {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'parent_id')
  int? parentId;

  @JsonKey(name: 'shipping_total')
  String? shippingTotal;

  @JsonKey(name: 'total_tax')
  String? totalTax;

  @JsonKey(name: 'cart_tax')
  String? cartTax;

  @JsonKey(name: 'shipping_tax')
  String? shippingTax;

  @JsonKey(name: 'discount_total')
  String? discountTotal;

  @JsonKey(name: 'discount_tax')
  String? discountTax;

  @JsonKey(name: 'currency_symbol')
  String? currencySymbol;

  @JsonKey(name: 'payment_method_title')
  String? paymentMethodTitle;

  @JsonKey(name: 'customer_note')
  String? customerNote;

  @JsonKey(name: 'date_created')
  String? dateCreated;

  @JsonKey(name: 'line_items')
  List<LineItems>? lineItems;

  @JsonKey(name: 'shipping_lines')
  List<ShippingLines>? shippingLines;

  Billing? billing;

  Shipping? shipping;

  String? total;

  String? status;

  String? currency;

  @JsonKey(name: 'vendor_order_details')
  VendorOrderDetails? vendorOrderDetails;

  OrderData({
    this.id,
    this.parentId,
    this.status,
    this.dateCreated,
    this.totalTax,
    this.cartTax,
    this.shippingTotal,
    this.shippingTax,
    this.discountTax,
    this.discountTotal,
    this.total,
    this.currencySymbol,
    this.currency,
    this.paymentMethodTitle,
    this.customerNote,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) => _$OrderDataFromJson(json);

  static List<LineItems> toList(List<dynamic>? data) {
    List<LineItems> lineItems = <LineItems>[];

    if (data == null) return lineItems;

    lineItems = data.map((d) => LineItems.fromJson(d)).toList().cast<LineItems>();
    return lineItems;
  }

  static List<ShippingLines> toShippingLines(List<dynamic>? data) {
    List<ShippingLines> shippingLines = <ShippingLines>[];

    if (data == null) return shippingLines;

    shippingLines = data.map((d) => ShippingLines.fromJson(d)).toList().cast<ShippingLines>();
    return shippingLines;
  }
}

@JsonSerializable(createToJson: false)
class ShippingLines {
  @JsonKey(name: 'method_title')
  String? methodTitle;
  String? total;
  @JsonKey(name: 'total_tax')
  String? totalTax;

  ShippingLines({this.methodTitle, this.total});

  factory ShippingLines.fromJson(Map<String, dynamic> json) => _$ShippingLinesFromJson(json);
}

@JsonSerializable(createToJson: false)
class LineItems {
  @JsonKey(name: 'meta_data')
  List<Map<String, dynamic>>? metaData;

  @JsonKey(name: 'product_id')
  int? productId;

  String? name;

  int? quantity;

  @JsonKey(fromJson: _toDouble)
  double? price;

  String? subtotal;

  String? total;

  String? sku;

  @JsonKey(name: 'image_url', toJson: _imageUrlToJson, fromJson: _imageUrlFromJson)
  String? imageUrl;

  @JsonKey(name: 'store_name')
  String? storeName;

  @JsonKey(name: 'commission_value', fromJson: _toDouble)
  double? commissionValue;

  LineItems({
    this.name,
    this.quantity,
    this.price,
    this.subtotal,
    this.metaData,
    this.sku,
    this.productId,
    this.storeName,
    this.commissionValue,
    this.imageUrl,
    this.total,
  });

  factory LineItems.fromJson(Map<String, dynamic> json) => _$LineItemsFromJson(json);

  static double? _toDouble(dynamic json) {
    return ConvertData.stringToDouble(json);
  }

  static dynamic _imageUrlToJson(dynamic json) {
    if (json == false) {
      return '';
    }
    return json;
  }

  static String? _imageUrlFromJson(dynamic value) {
    return value is String ? value : '';
  }
}

@JsonSerializable(createToJson: false)
class Billing {
  @JsonKey(name: 'first_name')
  String? firstName;

  @JsonKey(name: 'last_name')
  String? lastName;

  String? company;

  @JsonKey(name: 'address_1')
  String? address1;

  @JsonKey(name: 'address_2')
  String? address2;

  String? city;

  String? state;

  String? postcode;

  String? country;

  String? email;

  String? phone;

  Billing(
      {this.firstName,
      this.lastName,
      this.company,
      this.address1,
      this.address2,
      this.city,
      this.state,
      this.postcode,
      this.country,
      this.email,
      this.phone});

  factory Billing.fromJson(Map<String, dynamic> json) => _$BillingFromJson(json);
}

@JsonSerializable(createToJson: false)
class Shipping {
  @JsonKey(name: 'first_name')
  String? firstName;

  @JsonKey(name: 'last_name')
  String? lastName;

  String? company;

  @JsonKey(name: 'address_1')
  String? address1;

  @JsonKey(name: 'address_2')
  String? address2;

  String? city;

  String? state;

  String? postcode;

  String? country;

  Shipping(
      {this.firstName,
      this.lastName,
      this.company,
      this.address1,
      this.address2,
      this.city,
      this.state,
      this.postcode,
      this.country});

  factory Shipping.fromJson(Map<String, dynamic> json) => _$ShippingFromJson(json);
}

@JsonSerializable(createToJson: false)
class VendorOrderDetails {
  @JsonKey(name: 'item_sub_total')
  String? itemSubTotal;

  @JsonKey(name: 'item_total')
  String? itemTotal;

  String? shipping;

  String? tax;

  @JsonKey(name: 'discount_amount')
  String? discountAmount;

  @JsonKey(name: 'total_commission')
  String? totalCommission;

  VendorOrderDetails({
    this.itemSubTotal,
    this.itemTotal,
    this.shipping,
    this.tax,
    this.discountAmount,
    this.totalCommission,
  });
  factory VendorOrderDetails.fromJson(Map<String, dynamic> json) => _$VendorOrderDetailsFromJson(json);
}
