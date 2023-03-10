import 'package:country_locale_repository/country_locale_repository.dart';
import 'package:country_repository/country_repository.dart';
import 'package:customers_repository/customers_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/address/bloc/address_cubit.dart';
import 'package:flutter_store_manager/settings/cubit/settings_cubit.dart';
import 'package:flutter_store_manager/stores/global/global_store.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:flutter_store_manager/themes.dart';

import '../../../authentication/bloc/authentication_bloc.dart';
import '../bloc/update_personal_address_bloc.dart';
import 'widgets/address_body.dart';

class UpdatePersonalAddressScreen extends StatelessWidget with AppbarMixin {
  static const routeName = '/update_personal_address';

  const UpdatePersonalAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;

    return Scaffold(
      appBar: baseStyleAppBar(title: translate('account:text_address')),
      body: BlocProvider(
        create: (context) => UpdatePersonalAddressBloc(
          customersRepository: CustomersRepository(context.read<HttpClient>()),
          token: context.read<AuthenticationBloc>().state.token,
          user: context.read<AuthenticationBloc>().state.user,
          value: context.read<GlobalBloc>().state.stores['update_personal_address'],
          onChanged: (store) => context.read<GlobalBloc>().add(GlobalStoreChanged('update_personal_address', store)),
        ),
        child: BlocProvider<AddressCubit>(
          key: const Key("addressStoreSetup"),
          create: (_) => AddressCubit(
            countryRepository: CountryRepository(context.read<HttpClient>()),
            countryLocaleRepository: CountryLocaleRepository(context.read<HttpClient>()),
            token: context.read<AuthenticationBloc>().state.token,
            locale: context.read<SettingsCubit>().state.locate,
          ),
          child: const AddressBody(),
        ),
      ),
    );
  }
}
