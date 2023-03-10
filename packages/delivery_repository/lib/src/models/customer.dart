// Packages & Dependencies or Helper function
import 'package:json_annotation/json_annotation.dart';

part 'customer.g.dart';

@JsonSerializable(createToJson: false)
class CustomerDelivery {
  String? name;

  String? email;

  String? phone;

  CustomerDelivery({
    this.name,
    this.email,
    this.phone,
  });

  factory CustomerDelivery.fromJson(Map<String, dynamic> json) => _$CustomerDeliveryFromJson(json);
}
