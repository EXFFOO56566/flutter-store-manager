// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter_bloc/flutter_bloc.dart';

// Repository packages
import 'package:google_place_repository/google_place_repository.dart';
import 'package:store_setting_repository/store_setting_repository.dart';

// Bloc
import 'package:flutter_store_manager/authentication/authentication.dart';
import '../../../bloc/store_setting_bloc.dart';
import 'package:flutter_store_manager/stores/global/bloc/global_bloc.dart';

// View

import 'widgets/update_payment_body.dart';
import 'package:flutter_store_manager/themes.dart';

// Constants
import 'package:flutter_store_manager/constants/credentials.dart';

class UpdateStorePaymentScreen extends StatelessWidget with AppbarMixin {
  static const routeName = '/update_store_payment';

  const UpdateStorePaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return StoreSettingBloc(
            storeSettingRepository: StoreSettingRepository(context.read<HttpClient>()),
            googlePlaceRepository: GooglePlaceRepository(googleMapApiKey: googleMapApiKey)..init(),
            token: context.read<AuthenticationBloc>().state.token,
            value: context.read<GlobalBloc>().state.stores['store_setting'],
            onChanged: (store) => context.read<GlobalBloc>().add(GlobalStoreChanged('store_setting', store)));
      },
      child: const UpdateStorePaymentBody(),
    );
  }
}
