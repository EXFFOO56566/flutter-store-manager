// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';
import 'package:flutter_store_manager/pages/store_setting/view/update_store_info/view/widgets/field/store_email.dart';
import 'package:flutter_store_manager/pages/store_setting/view/update_store_info/view/widgets/field/store_name.dart';
import 'package:flutter_store_manager/types/types.dart';

// Repository packages
import 'package:store_setting_repository/store_setting_repository.dart';

// Bloc
import 'package:flutter_store_manager/address/address.dart';
import '../../../../bloc/store_setting_bloc.dart';

// View
import '../setup_store/address_form_body.dart';
import '../setup_store/get_location.dart';
import '../../../update_store_info/view/widgets/field/store_description.dart';
import '../../../update_store_info/view/widgets/field/store_phone.dart';
import '../../../update_store_info/view/widgets/store_banner_image.dart';
import '../../../update_store_info/view/widgets/store_logo_image.dart';

//Themes
import 'package:flutter_store_manager/themes.dart';

class StoreSetupInfo extends StatelessWidget with AppbarMixin, LoadingMixin {
  final Function onNextStep;
  const StoreSetupInfo({
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
      child: Scaffold(
        appBar: baseStyleAppBar(
          title: translate('auth:text_first_store'),
          automaticallyImplyLeading: false,
        ),
        body: BlocBuilder<StoreSettingBloc, StoreSettingState>(
          buildWhen: (previous, current) => (previous.storeSetting != current.storeSetting ||
              previous.getStoreSettingStatus != current.getStoreSettingStatus),
          builder: (context, state) {
            Address currentAddress = Address();
            if (state.storeSetting?.address != null) {
              currentAddress = state.storeSetting!.address!;
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
            return FixedBottom(
              key: const Key("multi_setup_info"),
              bottom: StoreSetupBottom(
                textButtonSecondary: translate('common:text_skip'),
                textButtonPrimary: translate('common:text_continue'),
                onPressedSecondary: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  onNextStep();
                },
                onPressedPrimary: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  context.read<StoreSettingBloc>().add(SubmitStep1Event(address));
                  onNextStep();
                },
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(25, 8, 25, 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const StoreLogoImage(),
                    const SizedBox(height: 15),
                    const StoreBannerImage(),
                    const SizedBox(height: 15),
                    StoreNameWidget(),
                    const SizedBox(height: 15),
                    StoreEmailWidget(),
                    const SizedBox(height: 15),
                    StorePhoneWidget(),
                    const SizedBox(height: 15),
                    AddressFormStoreSetup(
                      key: UniqueKey(),
                      currentAddress: currentAddress,
                      fromScreen: GetAddressFromScreen.setupInfo,
                      onChangedStateSetup: (value) {
                        address = value;
                      },
                    ),
                    const SizedBox(height: 15),
                    LabelInput(title: translate('inputs:text_store_location')),
                    BlocBuilder<StoreSettingBloc, StoreSettingState>(
                        buildWhen: (previous, current) => (previous.userLocationFromId != current.userLocationFromId),
                        builder: (context, state) {
                          return GetLocationField(
                            hintText: state.userLocationFromId?.address ?? translate('auth:text_find_map'),
                            storeSettingState: state,
                            // snapshot: snapshot,
                          );
                        }),
                    const SizedBox(height: 15),
                    StoreDescriptionWidget(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
