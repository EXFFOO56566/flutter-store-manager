import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:country_locale_repository/country_locale_repository.dart';
import 'package:country_repository/country_repository.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';
import 'package:flutter_store_manager/constants/app.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:store_setting_repository/store_setting_repository.dart';
import 'package:customers_repository/customers_repository.dart';

part 'address_state.dart';

class AddressCubit extends HydratedCubit<AddressState> {
  final pageSize = 10;
  final CountryRepository countryRepository;
  final CountryLocaleRepository countryLocaleRepository;
  final String token;
  final String locale;
  final RequestCancel _cancelToken = RequestCancel();

  AddressCubit({
    required this.countryRepository,
    required this.countryLocaleRepository,
    required this.token,
    required this.locale,
  }) : super(const AddressState(countries: []));

  ///setting store
  void selectCountry(String codeCountry) {
    emit(state.copyWith(
      codeCountrySelected: codeCountry,
      stateCode: "",
    ));
  }

  void changeFirstName(String firstName) {
    emit(state.copyWith(firstName: firstName));
  }

  void changeLastName(String lastName) {
    emit(state.copyWith(lastName: lastName));
  }

  void changeAddress1(String address) {
    emit(state.copyWith(address1: address));
  }

  void changeAddress2(String address) {
    emit(state.copyWith(address2: address));
  }

  void changeCity(String city) {
    emit(state.copyWith(city: city));
  }

  void changeZip(String zip) {
    emit(state.copyWith(zip: zip));
  }

  void selectState(String stateCode) {
    emit(state.copyWith(
      stateCode: stateCode,
    ));
  }

  ///support customer
  void selectSupportCountry(String codeCountry) {
    emit(state.copyWith(
      supportCodeCountrySelected: codeCountry,
      supportStateCode: "",
    ));
  }

  void changeSupportFirstName(String firstName) {
    emit(state.copyWith(supportFirstName: firstName));
  }

  void changeSupportLastName(String lastName) {
    emit(state.copyWith(supportLastName: lastName));
  }

  void changeSupportAddress1(String address) {
    emit(state.copyWith(supportAddress1: address));
  }

  void changeSupportAddress2(String address) {
    emit(state.copyWith(supportAddress2: address));
  }

  void changeSupportCity(String city) {
    emit(state.copyWith(supportCity: city));
  }

  void changeSupportZip(String zip) {
    emit(state.copyWith(supportZip: zip));
  }

  void selectSupportState(String supportStateCode) {
    emit(state.copyWith(
      supportStateCode: supportStateCode,
    ));
  }

  Future<void> getCountries() async {
    try {
      emit(state.copyWith(
        actionStateCountry: const LoadingState(),
      ));
      await _getCountries();
    } catch (_) {}
  }

  Future<void> getCountryLocale() async {
    try {
      emit(state.copyWith(
        actionStateCountryLocale: const LoadingState(),
      ));
      await _getCountryLocale();
    } catch (_) {}
  }

  Future<void> _getCountries() async {
    try {
      List<Country> data = await countryRepository.getCountry(
        requestData: RequestData(
          query: {
            'app-builder-decode': true,
            "consumer_key": consumerKey,
            "consumer_secret": consumerSecret,
          },
          token: token,
          cancelToken: _cancelToken,
        ),
      );
      if (data.isNotEmpty) {
        emit(
          state.copyWith(
            actionStateCountry: LoadedState(data: data.length),
            countries: data,
          ),
        );
      }
    } on RequestError catch (e) {
      if (e.type != RequestErrorType.cancel) {
        emit(state.copyWith(actionStateCountry: ErrorState(data: e.message)));
      }
      rethrow;
    }
  }

  Future<void> _getCountryLocale() async {
    try {
      final data = await countryLocaleRepository.getCountryLocale(
        requestData: RequestData(
          query: {'lang': locale, 'app-builder-decode': true},
          cancelToken: _cancelToken,
        ),
      );
      emit(
        state.copyWith(
          actionStateCountryLocale: LoadedState(data: data.length),
          countryLocale: data,
        ),
      );
    } on RequestError catch (e) {
      emit(state.copyWith(actionStateCountryLocale: ErrorState(data: e.message)));
      rethrow;
    }
  }

  void initAddress({Address? address, Address? supportAddress, Customers? billing, Customers? shipping}) {
    if (address != null) {
      emit(state.copyWith(
        codeCountrySelected: address.country ?? "",
        address1: address.street1 ?? "",
        address2: address.street2 ?? "",
        city: address.city ?? "",
        zip: address.zip ?? "",
        stateCode: address.state ?? "",
      ));
    }
    if (supportAddress != null) {
      emit(state.copyWith(
        supportCodeCountrySelected: supportAddress.country ?? "",
        supportAddress1: supportAddress.street1 ?? "",
        supportAddress2: supportAddress.street2 ?? "",
        supportCity: supportAddress.city ?? "",
        supportZip: supportAddress.zip ?? "",
        supportStateCode: supportAddress.state ?? "",
      ));
    }
    if (billing != null) {
      emit(state.copyWith(
        codeCountrySelected: billing.country,
        firstName: billing.firstName,
        lastName: billing.lastName,
        address1: billing.address1,
        address2: billing.address2,
        city: billing.city,
        zip: billing.postCode,
        stateCode: billing.state,
      ));
    }
    if (shipping != null) {
      emit(state.copyWith(
        supportCodeCountrySelected: shipping.country,
        supportFirstName: shipping.firstName,
        supportLastName: shipping.lastName,
        supportAddress1: shipping.address1,
        supportAddress2: shipping.address2,
        supportCity: shipping.city,
        supportZip: shipping.postCode,
        supportStateCode: shipping.state,
      ));
    }
  }

  void init() async {
    await getCountries();
    await getCountryLocale();
  }

  bool get loading => state.countries.isEmpty || state.countryLocale.isEmpty;

  @override
  AddressState? fromJson(Map<String, dynamic> json) {
    return AddressState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AddressState state) {
    return state.toJson();
  }

  @override
  Future<void> close() {
    _cancelToken.cancel();
    return super.close();
  }
}
