part of 'store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreInfo _$StoreInfoFromJson(Map<String, dynamic> json) => StoreInfo(
      name: json['name'] as String?,
      addressString: json['address_string'] as String?,
      storeAddress: StoreInfo._toStoreAddress(json['address']),
      storeCoordinate: StoreInfo._toStoreCoordinate(json['address_coordinate']),
    );
