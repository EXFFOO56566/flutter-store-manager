// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';
import 'package:flutter_store_manager/types/types.dart';

// Repository packages
import 'package:store_setting_repository/store_setting_repository.dart';

// Bloc
import 'package:flutter_store_manager/address/bloc/address_cubit.dart';
import '../../../../bloc/store_setting_bloc.dart';

// View
import '../setup_store/address_form_body.dart';
import '../support_setup/field/support_email.dart';
import '../support_setup/field/support_phone.dart';

//Themes
import 'package:flutter_store_manager/themes.dart';

class StoreSetupSupport extends StatelessWidget with AppbarMixin, LoadingMixin {
  final Function onNextStep;

  const StoreSetupSupport({
    Key? key,
    required this.onNextStep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Address address = Address();
    TranslateType translate = AppLocalizations.of(context)!.translate;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: BlocBuilder<StoreSettingBloc, StoreSettingState>(
        builder: (context, state) {
          Address supportAddress = Address(
            state: state.storeSetting?.customerSupport?.state,
            country: state.storeSetting?.customerSupport?.country ?? state.storeSetting?.address?.country,
            zip: state.storeSetting?.customerSupport?.zip,
            city: state.storeSetting?.customerSupport?.city,
            street1: state.storeSetting?.customerSupport?.address1,
            street2: state.storeSetting?.customerSupport?.address2,
          );
          if (state.storeSetting == null) {
            context.read<StoreSettingBloc>().add(const GetStoreSettingEvent());
          }
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
          return Scaffold(
            appBar: baseStyleAppBar(
              title: translate('auth:text_forth_support'),
              automaticallyImplyLeading: false,
            ),
            body: FixedBottom(
              bottom: StoreSetupBottom(
                textButtonSecondary: translate('common:text_skip'),
                textButtonPrimary: translate('common:text_continue'),
                onPressedSecondary: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  onNextStep();
                },
                onPressedPrimary: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  context.read<StoreSettingBloc>().add(SubmitStep4Event(address));
                  onNextStep();
                },
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
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
                    AddressFormStoreSetup(
                      key: UniqueKey(),
                      fromScreen: GetAddressFromScreen.supportCustomer,
                      supportAddress: supportAddress,
                      onChangedStateSupport: (value) {
                        address = value;
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
