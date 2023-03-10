// Packages & Dependencies or Helper function
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delivery_stat.g.dart';

@JsonSerializable(createToJson: false)
class DeliveryStat {
  @JsonKey(fromJson: _toInt)
  int pending;

  @JsonKey(fromJson: _toInt)
  int delivered;

  DeliveryStat({this.pending = 0, this.delivered = 0});

  factory DeliveryStat.fromJson(Map<String, dynamic> json) => _$DeliveryStatFromJson(json);

  static int _toInt(dynamic value) {
    return ConvertData.stringToInt(value, 0);
  }
}
