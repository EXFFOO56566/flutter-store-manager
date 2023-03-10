// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';
import 'package:flutter_store_manager/types/types.dart';

// Repository packages
import 'package:country_locale_repository/country_locale_repository.dart';
import 'package:country_repository/country_repository.dart';
import 'package:store_setting_repository/store_setting_repository.dart';

// Bloc
import 'package:flutter_store_manager/address/bloc/address_cubit.dart';
import 'package:flutter_store_manager/authentication/authentication.dart';
import '../../../bloc/store_setting_bloc.dart';
import 'package:flutter_store_manager/settings/cubit/settings_cubit.dart';

// View

import '../../multi_store_setup_register/view/setup_store/address_form_body.dart';
import '../../multi_store_setup_register/view/support_setup/field/support_email.dart';
import '../../multi_store_setup_register/view/support_setup/field/support_phone.dart';

//Themes
import 'package:flutter_store_manager/themes.dart';

class StoreSetupSupportBody extends StatelessWidget with AppbarMixin, LoadingMixin {
  const StoreSetupSupportBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Address address = Address();
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;
    context.read<StoreSettingBloc>().add(const GetStoreSettingEvent());
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: baseStyleAppBar(
          title: translate('auth:text_setup_support'),
        ),
        body: BlocConsumer<StoreSettingBloc, StoreSettingState>(
          builder: (context, state) {
            Address supportAddress = Address(
              state: state.storeSetting?.customerSupport?.state,
              country: state.storeSetting?.customerSupport?.country ?? state.storeSetting?.address?.country,
              zip: state.storeSetting?.customerSupport?.zip,
              city: state.storeSetting?.customerSupport?.city,
              street1: state.storeSetting?.customerSupport?.address1,
              street2: state.storeSetting?.customerSupport?.address2,
            );
            if (state.getStoreSettingStatus == const LoadingState()) {
              return Center(child: buildLoading());
            } else if (state.getStoreSettingStatus == const ErrorState()) {
              return Column(
                children: const [
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Error'),
                  )
                ],
              );
            }
            return FixedBottom(
              bottom: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        context.read<StoreSettingBloc>().add(SubmitStep4Event(address, isSingle: true));
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(100, 50),
                        minimumSize: const Size(0, 41),
                        padding: EdgeInsets.zero,
                        textStyle: theme.textTheme.button?.copyWith(fontSize: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: (state.submitSupportStatus == const LoadingState())
                          ? buildLoadingElevated()
                          : Text(translate('common:text_button_save')),
                    ),
                  ),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(25, 18, 25, 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SupportPhoneWidget(),
                    const SizedBox(height: 15),
                    SupportEmailWidget(),
                    const SizedBox(height: 15),
                    BlocProvider<AddressCubit>(
                      create: (_) => AddressCubit(
                        countryRepository: CountryRepository(context.read<HttpClient>()),
                        countryLocaleRepository: CountryLocaleRepository(context.read<HttpClient>()),
                        token: context.read<AuthenticationBloc>().state.token,
                        locale: context.read<SettingsCubit>().state.locate,
                      ),
                      child: AddressFormStoreSetup(
                        key: UniqueKey(),
                        fromScreen: GetAddressFromScreen.supportCustomer,
                        supportAddress: supportAddress,
                        onChangedStateSupport: (value) {
                          address = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          listenWhen: (previous, current) => previous.submitSupportStatus != current.submitSupportStatus,
          listener: (context, state) {
            if (state.submitSupportStatus == const LoadedState()) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(translate('common:text_success')),
              ));
            }
            if (state.submitSupportStatus == const ErrorState()) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(translate('common:text_failure')),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
