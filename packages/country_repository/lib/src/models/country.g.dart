// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
      code: (json['code'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      states: json['states'] is List
          ? json['states'].map((data) => StateData.fromJson(data)).toList().cast<StateData>()
          : [],
    );

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'states': instance.states.map((e) => e.toJson()).toList(),
    };
