// Packages & Dependencies or Helper function
import 'package:json_annotation/json_annotation.dart';

// Models
import 'state.dart';

part 'country.g.dart';

@JsonSerializable()
class Country {
  String code;
  String name;
  List<StateData> states;

  Country({
    required this.code,
    required this.name,
    required this.states,
  });

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);
  Map<String, dynamic> toJson() => _$CountryToJson(this);
}
