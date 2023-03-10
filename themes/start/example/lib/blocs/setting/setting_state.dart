part of 'setting_cubit.dart';

class SettingState {
  final bool showOnBoarding;
  final Brightness brightness;
  final String locale;

  const SettingState({
    this.showOnBoarding = true,
    this.brightness = Brightness.light,
    this.locale = defaultLocale,
  });

  List<Object?> get props => [showOnBoarding, brightness];

  SettingState copyWith({
    bool? showOnBoarding,
    Brightness? brightness,
    String? locale,
  }) {
    return SettingState(
      showOnBoarding: showOnBoarding ?? this.showOnBoarding,
      brightness: brightness ?? this.brightness,
      locale: locale ?? this.locale,
    );
  }

  factory SettingState.fromJson(Map<String, dynamic> json) => _$SettingStateFromJson(json);

  Map<String, dynamic> toJson() => _$SettingStateToJson(this);
}

SettingState _$SettingStateFromJson(Map<String, dynamic> json) => SettingState(
      showOnBoarding: json['show_boarding'] as bool,
      brightness: Brightness.values[json['brightness'] as int],
      locale: (json['locale'] ?? defaultLocale) as String,
    );

Map<String, dynamic> _$SettingStateToJson(SettingState instance) => <String, dynamic>{
      'show_boarding': instance.showOnBoarding,
      'brightness': instance.brightness.index,
      'locale': instance.locale,
    };
