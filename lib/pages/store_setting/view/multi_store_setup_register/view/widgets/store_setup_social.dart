// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';
import 'package:flutter_store_manager/types/types.dart';

// Bloc
import '../../../../bloc/store_setting_bloc.dart';

// View
import '../social/field/facebook.dart';
import '../social/field/google.dart';
import '../social/field/insta.dart';
import '../social/field/likedin.dart';
import '../social/field/pinterest.dart';
import '../social/field/snapchat.dart';
import '../social/field/twitter.dart';
import '../social/field/youtube.dart';

//Themes
import 'package:flutter_store_manager/themes.dart';

class StoreSetupSocial extends StatelessWidget with AppbarMixin, LoadingMixin {
  final Function onNextStep;

  const StoreSetupSocial({
    Key? key,
    required this.onNextStep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
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
              title: translate('auth:text_sixth_social'),
              automaticallyImplyLeading: false,
            ),
            body: FixedBottom(
              bottom: StoreSetupBottom(
                textButtonSecondary: translate('common:text_skip'),
                textButtonPrimary: translate('common:text_continue'),
                onPressedSecondary: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  context.read<StoreSettingBloc>().add(const SubmitMultiStepEvent());
                  onNextStep();
                },
                onPressedPrimary: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  context.read<StoreSettingBloc>().add(const SubmitStep6Event());
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
