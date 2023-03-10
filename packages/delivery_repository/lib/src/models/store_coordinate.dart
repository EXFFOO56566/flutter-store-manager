// Packages & Dependencies or Helper function
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'store_coordinate.g.dart';

@JsonSerializable(createToJson: false)
class StoreCoordinate {
  @JsonKey(name: 'store_lat', fromJson: _toInt)
  int? lat;

  @JsonKey(name: 'store_lng', fromJson: _toInt)
  int? lng;

  StoreCoordinate({
    this.lat,
    this.lng,
  });

  factory StoreCoordinate.fromJson(Map<String, dynamic> json) => _$StoreCoordinateFromJson(json);

  static int _toInt(dynamic value) {
    return ConvertData.stringToInt(value, 0);
  }
}
