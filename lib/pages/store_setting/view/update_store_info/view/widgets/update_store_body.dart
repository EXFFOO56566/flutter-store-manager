// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'package:formz/formz.dart';

// Repository packages
import 'package:store_setting_repository/store_setting_repository.dart';

// Bloc
import 'package:flutter_store_manager/address/address.dart';
import '../../../../bloc/store_setting_bloc.dart';

// View
import '../../../multi_store_setup_register/view/setup_store/address_form_body.dart';
import '../../../multi_store_setup_register/view/setup_store/get_location.dart';
import '../../../update_store_info/view/widgets/field/store_description.dart';
import '../../../update_store_info/view/widgets/field/store_email.dart';
import '../../../update_store_info/view/widgets/field/store_name.dart';
import '../../../update_store_info/view/widgets/field/store_phone.dart';
import '../../../update_store_info/view/widgets/store_banner_image.dart';
import '../../../update_store_info/view/widgets/store_logo_image.dart';
import '../../../update_store_info/view/widgets/store_mobile_banner_image.dart';

//Themes
import 'package:flutter_store_manager/themes.dart';

class UpdateStoreInfoBody extends StatefulWidget with AppbarMixin {
  const UpdateStoreInfoBody({Key? key}) : super(key: key);

  @override
  State<UpdateStoreInfoBody> createState() => _UpdateStoreInfoBodyState();
}

class _UpdateStoreInfoBodyState extends State<UpdateStoreInfoBody> with AppbarMixin, LoadingMixin {
  @override
  void initState() {
    context.read<StoreSettingBloc>().add(const GetStoreSettingEvent());
    context.read<AddressCubit>().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Address address = Address();
    TranslateType translate = AppLocalizations.of(context)!.translate;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: baseStyleAppBar(title: translate('account:text_general_store')),
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
              bottom: BlocConsumer<StoreSettingBloc, StoreSettingState>(
                buildWhen: (previous, current) => previous.statusSaveSetting != current.statusSaveSetting,
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state.statusSaveSetting.isValidated
                        ? () {
                            if (!state.statusSaveSetting.isSubmissionInProgress) {
                              FocusManager.instance.primaryFocus?.unfocus();
                              context.read<StoreSettingBloc>().add(SubmitStep1Event(address, isSingle: true));
                            }
                          }
                        : null,
                    child: state.statusSaveSetting.isSubmissionInProgress
                        ? buildLoadingElevated()
                        : Text(AppLocalizations.of(context)!.translate('common:text_button_save')),
                  );
                },
                listenWhen: (previous, current) => previous.statusSaveSetting != current.statusSaveSetting,
                listener: (context, state) {
                  switch (state.statusSaveSetting) {
                    case FormzStatus.submissionSuccess:
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(translate('common:text_success')),
                      ));
                      break;
                    case FormzStatus.submissionFailure:
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(translate('common:text_failure')),
                        ),
                      );
                      break;
                    default:
                      break;
                  }
                },
              ),
              paddingBottom: const EdgeInsets.all(25),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(25, 8, 25, 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    const SizedBox(height: 15),
                    const StoreLogoImage(),
                    const SizedBox(height: 15),
                    const StoreBannerImage(),
                    const SizedBox(height: 15),
                    const StoreMobileBannerImage(),
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
