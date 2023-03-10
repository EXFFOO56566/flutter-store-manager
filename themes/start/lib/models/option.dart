class Option {
  final String key;
  final String name;
  final List<Option>? options;
  final bool enabled;

  const Option({required this.key, required this.name, this.options, this.enabled = true});

  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);

  Map<String, dynamic> toJson() => _$OptionToJson(this);
}

Option _$OptionFromJson(Map<String, dynamic> json) => Option(
      key: json['key'] as String,
      name: json['name'] as String,
      enabled: json['enable'] as bool,
      options: (json['options'] as List<dynamic>?)?.map((e) => Option.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$OptionToJson(Option instance) => <String, dynamic>{
      'key': instance.key,
      'name': instance.name,
      'enable': instance.enabled,
      'options': instance.options,
    };
