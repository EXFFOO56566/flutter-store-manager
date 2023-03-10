import 'package:example/blocs/blocs.dart';
import 'package:example/screens/store_setup/bloc/store_setting_bloc.dart';
import 'package:example/screens/store_setup/model/store_model.dart';
import 'package:example/screens/store_setup/widget/field/store_description.dart';
import 'package:example/screens/store_setup/widget/field/store_phone.dart';
import 'package:example/screens/store_setup/widget/get_location.dart';
import 'package:example/screens/store_setup/widget/store_banner_image.dart';
import 'package:example/screens/store_setup/widget/store_logo_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/ui.dart';

class StoreSetupInfo extends StatelessWidget with AppbarMixin {
  final Function onNextStep;
  const StoreSetupInfo({
    Key? key,
    required this.onNextStep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Address address = Address();
    context.read<StoreSettingBloc>().add(const GetStoreSettingEvent());
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: BlocBuilder<StoreSettingBloc, StoreSettingState>(
        builder: (context, state) {
          // Address _currentAddress = Address();
          if (state.storeSetting?.address != null) {
            // _currentAddress = state.storeSetting!.address!;
          }
          if (state.getStoreSettingStatus == const LoadingState()) {
            return Container(color: Colors.white, child: const CupertinoActivityIndicator());
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
              title: "1.Store Setup",
              automaticallyImplyLeading: false,
            ),
            body: FixedBottom(
              bottom: StoreSetupBottom(
                textButtonSecondary: "Skip",
                textButtonPrimary: "Continue",
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
                    StorePhoneWidget(),
                    const SizedBox(height: 15),
                    const LabelInput(title: "Location"),
                    BlocBuilder<StoreSettingBloc, StoreSettingState>(
                        buildWhen: (previous, current) => (previous.userLocationFromId != current.userLocationFromId),
                        builder: (context, state) {
                          return GetLocationField(
                            hintText: state.userLocationFromId?.address ?? "Find on map",
                            storeSettingState: state,
                            // snapshot: snapshot,
                          );
                        }),
                    const SizedBox(height: 15),
                    StoreDescriptionWidget(),
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
