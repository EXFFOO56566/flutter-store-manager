// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Place _$PlaceFromJson(Map<String, dynamic> json) => Place(
      placeId: json['place_id'] as String,
      addressComponents: json['address_components'] as List<dynamic>,
      address: json['formatted_address'] as String,
      location: Place._fromGeometry(json['geometry']),
    );

Map<String, dynamic> _$PlaceToJson(Place instance) => <String, dynamic>{
      'place_id': instance.placeId,
      'address_components': instance.addressComponents,
      'formatted_address': instance.address,
      'geometry': instance.location,
    };
