// Packages & Dependencies or Helper function
import 'package:json_annotation/json_annotation.dart';

part 'customers.g.dart';

@JsonSerializable()
class Customers {
  int? id;

  @JsonKey(name: "first_name")
  String? firstName;

  @JsonKey(name: "last_name")
  String? lastName;

  String? company;

  @JsonKey(name: "address_1")
  String? address1;

  @JsonKey(name: "address_2")
  String? address2;

  String? city;

  String? postCode;

  String? country;

  String? state;

  String? email;

  String? phone;

  Customers({
    this.id,
    this.firstName,
    this.lastName,
    this.company,
    this.address1,
    this.address2,
    this.city,
    this.postCode,
    this.country,
    this.state,
    this.email,
    this.phone,
  });

  factory Customers.fromJson(Map<String, dynamic> json) => _$CustomersFromJson(json);

  Map<String, dynamic> toJson() => _$CustomersToJson(this);
}
