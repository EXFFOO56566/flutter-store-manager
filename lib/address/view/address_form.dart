import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:country_locale_repository/country_locale_repository.dart';
import 'package:country_repository/country_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/address/address.dart';
import 'package:flutter_store_manager/authentication/authentication.dart';
import 'package:flutter_store_manager/settings/settings.dart';

import '../widgets/address_form_body.dart';

class AddressForm extends StatelessWidget {
  const AddressForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HttpClient httpClient = context.read<HttpClient>();
    return BlocProvider<AddressCubit>(
      create: (_) => AddressCubit(
        countryRepository: CountryRepository(httpClient),
        countryLocaleRepository: CountryLocaleRepository(httpClient),
        token: context.read<AuthenticationBloc>().state.token,
        locale: context.read<SettingsCubit>().state.locate,
      ),
      child: const AddressFormBody(),
    );
  }
}
