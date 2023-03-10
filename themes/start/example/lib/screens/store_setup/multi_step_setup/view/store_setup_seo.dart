import 'package:example/blocs/blocs.dart';
import 'package:example/screens/store_setup/bloc/store_setting_bloc.dart';
import 'package:example/screens/store_setup/widget/facebook_image.dart';
import 'package:example/screens/store_setup/widget/field/face_des.dart';
import 'package:example/screens/store_setup/widget/field/facebook_title.dart';
import 'package:example/screens/store_setup/widget/field/meta_des.dart';
import 'package:example/screens/store_setup/widget/field/meta_key.dart';
import 'package:example/screens/store_setup/widget/field/seo_title.dart';
import 'package:example/screens/store_setup/widget/field/twitter_des.dart';
import 'package:example/screens/store_setup/widget/field/twitter_title.dart';
import 'package:example/screens/store_setup/widget/twitter_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/ui.dart';

class StoreSetupSeo extends StatelessWidget with AppbarMixin {
  final Function onNextStep;

  const StoreSetupSeo({
    Key? key,
    required this.onNextStep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
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
              title: "5.SEO",
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
                  context.read<StoreSettingBloc>().add(const SubmitStep5Event());
                  onNextStep();
                },
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(25, 18, 25, 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Store SEO Setup", style: theme.textTheme.headline6),
                    const SizedBox(height: 20),
                    SeoTitleWidget(),
                    const SizedBox(height: 15),
                    MetaDesWidget(),
                    const SizedBox(height: 15),
                    MetaKeyWidget(),
                    const SizedBox(height: 40),
                    Text("Facebook Setup", style: theme.textTheme.headline6),
                    const SizedBox(height: 20),
                    FaceBookTitleWidget(),
                    const SizedBox(height: 15),
                    FaceBookDesWidget(),
                    const SizedBox(height: 15),
                    const FacebookImage(),
                    const SizedBox(height: 40),
                    Text("Twitter Setup", style: theme.textTheme.headline6),
                    const SizedBox(height: 20),
                    TwitterTitleWidget(),
                    const SizedBox(height: 15),
                    TwitterDesWidget(),
                    const SizedBox(height: 15),
                    const TwitterImage(),
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
