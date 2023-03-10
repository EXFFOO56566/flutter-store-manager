// Packages & Dependencies or Helper function
import 'package:json_annotation/json_annotation.dart';

import 'store_address.dart';
import 'store_coordinate.dart';
part 'store.g.dart';

@JsonSerializable(createToJson: false)
class StoreInfo {
  String? name;

  @JsonKey(name: 'address_string')
  String? addressString;

  @JsonKey(name: 'address', fromJson: _toStoreAddress)
  StoreAddress? storeAddress;

  @JsonKey(name: 'address_coordinate', fromJson: _toStoreCoordinate)
  StoreCoordinate? storeCoordinate;

  StoreInfo({
    this.name,
    this.addressString,
    this.storeAddress,
    this.storeCoordinate,
  });

  factory StoreInfo.fromJson(Map<String, dynamic> json) => _$StoreInfoFromJson(json);

  static StoreAddress _toStoreAddress(dynamic value) {
    return StoreAddress.fromJson(value ?? {});
  }

  static StoreCoordinate _toStoreCoordinate(dynamic value) {
    Map<String, dynamic> data = value is Map
        ? {
            'store_lat': value['store_lat'],
            'store_lng': value['store_lng'],
          }
        : {};
    return StoreCoordinate.fromJson(data);
  }
}
