import 'package:example/blocs/blocs.dart';
import 'package:example/screens/store_setup/bloc/store_setting_bloc.dart';
import 'package:example/screens/store_setup/widget/field/facebook.dart';
import 'package:example/screens/store_setup/widget/field/google.dart';
import 'package:example/screens/store_setup/widget/field/insta.dart';
import 'package:example/screens/store_setup/widget/field/likedin.dart';
import 'package:example/screens/store_setup/widget/field/pinterest.dart';
import 'package:example/screens/store_setup/widget/field/snapchat.dart';
import 'package:example/screens/store_setup/widget/field/twitter.dart';
import 'package:example/screens/store_setup/widget/field/youtube.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/ui.dart';

class StoreSetupSocial extends StatelessWidget with AppbarMixin {
  final Function onNextStep;

  const StoreSetupSocial({
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
              title: "6.Social",
              automaticallyImplyLeading: false,
            ),
            body: FixedBottom(
              bottom: StoreSetupBottom(
                textButtonSecondary: "Skip",
                textButtonPrimary: "Continue",
                onPressedSecondary: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  context.read<StoreSettingBloc>().add(const SubmitMultiStepEvent());
                  onNextStep();
                },
                onPressedPrimary: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  context.read<StoreSettingBloc>().add(const SubmitMultiStepEvent());
                  onNextStep();
                },
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(25, 18, 25, 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TwitterLinkWidget(),
                    const SizedBox(height: 15),
                    FacebookLinkWidget(),
                    const SizedBox(height: 15),
                    InstaLinkWidget(),
                    const SizedBox(height: 15),
                    YoutubeLinkWidget(),
                    const SizedBox(height: 15),
                    LikeinLinkWidget(),
                    const SizedBox(height: 15),
                    GoogleLinkWidget(),
                    const SizedBox(height: 15),
                    SnapLinkWidget(),
                    const SizedBox(height: 15),
                    PinterLinkWidget(),
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
