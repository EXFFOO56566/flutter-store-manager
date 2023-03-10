import 'package:example/blocs/blocs.dart';
import 'package:example/screens/store_setup/bloc/store_setting_bloc.dart';
import 'package:example/screens/store_setup/widget/field/cancel_policy.dart';
import 'package:example/screens/store_setup/widget/field/refund_policy.dart';
import 'package:example/screens/store_setup/widget/field/shipping_policy.dart';
import 'package:example/screens/store_setup/widget/field/tab_policy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/ui.dart';

class StoreSetupPolicy extends StatelessWidget with AppbarMixin {
  final Function onNextStep;

  const StoreSetupPolicy({
    Key? key,
    required this.onNextStep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: BlocBuilder<StoreSettingBloc, StoreSettingState>(
        builder: (context, state) {
          if (state.storeSetting == null) {
            context.read<StoreSettingBloc>().add(const GetStoreSettingEvent());
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
              title: "3.Policy",
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
                  context.read<StoreSettingBloc>().add(const SubmitStep3Event());
                  onNextStep();
                },
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(25, 18, 25, 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TabPolicyWidget(),
                    const SizedBox(height: 15),
                    ShippingPolicyWidget(),
                    const SizedBox(height: 15),
                    RefundPolicyWidget(),
                    const SizedBox(height: 15),
                    CancelPolicyWidget(),
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
