// Packages & Dependencies or Helper function
import 'package:json_annotation/json_annotation.dart';

part 'store_address.g.dart';

@JsonSerializable(createToJson: false)
class StoreAddress {
  @JsonKey(name: 'street_1')
  String? street1;

  @JsonKey(name: 'street_2')
  String? street2;

  String? city;

  String? zip;

  String? state;

  String? country;

  StoreAddress({
    this.street1,
    this.street2,
    this.city,
    this.state,
    this.zip,
    this.country,
  });

  factory StoreAddress.fromJson(Map<String, dynamic> json) => _$StoreAddressFromJson(json);
}
