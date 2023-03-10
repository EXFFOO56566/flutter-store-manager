// Packages & Dependencies or Helper function
import 'package:json_annotation/json_annotation.dart';

part 'shipping_address.g.dart';

@JsonSerializable(createToJson: false)
class ShippingAddress {
  @JsonKey(name: 'first_name')
  String? firstName;

  @JsonKey(name: 'last_name')
  String? lastName;

  String? company;

  @JsonKey(name: 'address_1')
  String? address1;

  @JsonKey(name: 'last_name')
  String? address2;

  String? city;

  String? state;

  String? postcode;

  String? country;

  String? phone;

  ShippingAddress({
    this.firstName,
    this.lastName,
    this.company,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.postcode,
    this.country,
    this.phone,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) => _$ShippingAddressFromJson(json);
}
