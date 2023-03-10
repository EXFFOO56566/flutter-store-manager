import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_store_manager/constants/languages.dart';

class Setting extends Equatable {
  final bool enableOnBoarding;
  final String locate;
  final Brightness brightness;

  const Setting({
    this.enableOnBoarding = false,
    required this.locate,
    required this.brightness,
  });

  static const Setting empty = Setting(locate: defaultLocale, brightness: Brightness.light, enableOnBoarding: false);

  factory Setting.fromJson(Map<String, dynamic> json) => _$SettingFromJson(json);

  Map<String, dynamic> toJson() => _$SettingToJson(this);

  Setting copyWith({
    String? locate,
    Brightness? brightness,
    bool? enableOnBoarding,
  }) {
    return Setting(
      locate: locate ?? this.locate,
      brightness: brightness ?? this.brightness,
      enableOnBoarding: enableOnBoarding ?? this.enableOnBoarding,
    );
  }

  @override
  List<Object> get props => [locate, brightness, enableOnBoarding];
}

Setting _$SettingFromJson(Map<String, dynamic> json) => Setting(
      locate: json['locate'] as String,
      brightness: Brightness.values[json['brightness'] as int],
      enableOnBoarding: (json['enableOnBoarding'] ?? false) as bool,
    );

Map<String, dynamic> _$SettingToJson(Setting instance) => <String, dynamic>{
      'locate': instance.locate,
      'brightness': instance.brightness.index,
      'enableOnBoarding': instance.enableOnBoarding,
    };
