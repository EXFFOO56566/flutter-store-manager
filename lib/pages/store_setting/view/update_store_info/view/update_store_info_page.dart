// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// Packages & Dependencies or Helper function
import 'package:flutter_bloc/flutter_bloc.dart';

// Repository packages
import 'package:country_locale_repository/country_locale_repository.dart';
import 'package:country_repository/country_repository.dart';
import 'package:google_place_repository/google_place_repository.dart';
import 'package:store_setting_repository/store_setting_repository.dart';

// Bloc
import 'package:flutter_store_manager/address/address.dart';
import 'package:flutter_store_manager/authentication/authentication.dart';
import '../../../bloc/store_setting_bloc.dart';
import 'package:flutter_store_manager/settings/cubit/settings_cubit.dart';
import 'package:flutter_store_manager/stores/global/bloc/global_bloc.dart';

// View
import 'widgets/update_store_body.dart';
import 'package:flutter_store_manager/themes.dart';

// Constants
import 'package:flutter_store_manager/constants/credentials.dart';

class UpdateStoreInfoScreen extends StatelessWidget with AppbarMixin {
  static const routeName = '/update_store_info';

  const UpdateStoreInfoScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return BlocProvider(
          create: (context) {
            return StoreSettingBloc(
                storeSettingRepository: StoreSettingRepository(context.read<HttpClient>()),
                googlePlaceRepository: GooglePlaceRepository(googleMapApiKey: googleMapApiKey)..init(),
                token: context.read<AuthenticationBloc>().state.token,
                value: context.read<GlobalBloc>().state.stores['store_setting'],
                storeNameInit: "${state.user.firstName} ${state.user.lastName}",
                storeEmailInit: state.user.userEmail,
                onChanged: (store) => context.read<GlobalBloc>().add(GlobalStoreChanged('store_setting', store)));
          },
          child: BlocProvider<AddressCubit>(
            key: const Key("addressStoreSetup"),
            create: (_) => AddressCubit(
              countryRepository: CountryRepository(context.read<HttpClient>()),
              countryLocaleRepository: CountryLocaleRepository(context.read<HttpClient>()),
              token: context.read<AuthenticationBloc>().state.token,
              locale: context.read<SettingsCubit>().state.locate,
            ),
            child: const UpdateStoreInfoBody(),
          ),
        );
      },
    );
  }
}
