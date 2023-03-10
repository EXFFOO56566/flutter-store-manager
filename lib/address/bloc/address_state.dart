part of 'address_cubit.dart';

enum GetAddressFromScreen { setupInfo, supportCustomer }

class AddressState extends BaseState {
  final List<Country> countries;
  final Map countryLocale;
  final String? codeCountrySelected;
  final BaseState actionStateCountry;
  final BaseState actionStateCountryLocale;
  final String? firstName;
  final String? lastName;
  final String? address1;
  final String? address2;
  final String? city;
  final String? zip;
  final String? stateCode;
  final String? supportCodeCountrySelected;
  final String? supportFirstName;
  final String? supportLastName;
  final String? supportAddress1;
  final String? supportAddress2;
  final String? supportCity;
  final String? supportZip;
  final String? supportStateCode;

  const AddressState({
    this.countries = const [],
    this.countryLocale = const {},
    this.codeCountrySelected,
    this.actionStateCountry = const InitState(),
    this.actionStateCountryLocale = const InitState(),
    this.firstName,
    this.lastName,
    this.address1,
    this.address2,
    this.city,
    this.zip,
    this.stateCode,
    this.supportCodeCountrySelected,
    this.supportFirstName,
    this.supportLastName,
    this.supportAddress1,
    this.supportAddress2,
    this.supportCity,
    this.supportStateCode,
    this.supportZip,
  });

  @override
  List<Object?> get props => [
        countries,
        countryLocale,
        codeCountrySelected,
        actionStateCountry,
        actionStateCountryLocale,
        address1,
        address2,
        firstName,
        lastName,
        city,
        zip,
        stateCode,
        supportCodeCountrySelected,
        supportFirstName,
        supportLastName,
        supportAddress1,
        supportAddress2,
        supportCity,
        supportZip,
        supportStateCode,
      ];

  AddressState copyWith({
    List<Country>? countries,
    Map? countryLocale,
    String? codeCountrySelected,
    BaseState? actionStateCountry,
    BaseState? actionStateCountryLocale,
    int? page,
    String? firstName,
    String? lastName,
    String? address1,
    String? address2,
    String? city,
    String? zip,
    String? stateCode,
    String? supportCodeCountrySelected,
    String? supportFirstName,
    String? supportLastName,
    String? supportAddress1,
    String? supportAddress2,
    String? supportCity,
    String? supportZip,
    String? supportStateCode,
  }) {
    return AddressState(
      countries: countries ?? this.countries,
      countryLocale: countryLocale ?? this.countryLocale,
      codeCountrySelected: codeCountrySelected ?? this.codeCountrySelected,
      actionStateCountry: actionStateCountry ?? this.actionStateCountry,
      actionStateCountryLocale: actionStateCountryLocale ?? this.actionStateCountryLocale,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      city: city ?? this.city,
      zip: zip ?? this.zip,
      stateCode: stateCode ?? this.stateCode,
      supportCodeCountrySelected: supportCodeCountrySelected ?? this.supportCodeCountrySelected,
      supportFirstName: supportFirstName ?? this.supportFirstName,
      supportLastName: supportLastName ?? this.supportLastName,
      supportAddress1: supportAddress1 ?? this.supportAddress1,
      supportAddress2: supportAddress2 ?? this.supportAddress2,
      supportCity: supportCity ?? this.supportCity,
      supportZip: supportZip ?? this.supportZip,
      supportStateCode: supportStateCode ?? this.supportStateCode,
    );
  }

  factory AddressState.fromJson(Map<String, dynamic> json) => _$AddressStateFromJson(json);

  Map<String, dynamic> toJson() => _$AddressStateStateToJson(this);
}

AddressState _$AddressStateFromJson(Map<String, dynamic> json) => AddressState(
    countries: (json['country'] as List).map((e) => Country.fromJson(e)).toList(), countryLocale: json['locale']);

Map<String, dynamic> _$AddressStateStateToJson(AddressState instance) => <String, dynamic>{
      'country': instance.countries.map((e) => e.toJson()).toList(),
      'locale': instance.countryLocale,
    };
