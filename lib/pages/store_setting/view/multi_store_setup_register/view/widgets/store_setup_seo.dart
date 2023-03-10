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
import '../seo/field/face_des.dart';
import '../seo/field/facebook_title.dart';
import '../seo/field/meta_des.dart';
import '../seo/field/meta_key.dart';
import '../seo/field/seo_title.dart';
import '../seo/field/twitter_des.dart';
import '../seo/field/twitter_title.dart';
import '../../../update_store_info/view/widgets/facebook_image.dart';
import '../../../update_store_info/view/widgets/twitter_image.dart';

//Themes
import 'package:flutter_store_manager/themes.dart';

class StoreSetupSeo extends StatelessWidget with AppbarMixin, LoadingMixin {
  final Function onNextStep;

  const StoreSetupSeo({
    Key? key,
    required this.onNextStep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
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
              title: translate('auth:text_fifth_seo'),
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
                    Text(translate('auth:text_store_seo_setup'), style: theme.textTheme.headline6),
                    const SizedBox(height: 20),
                    SeoTitleWidget(),
                    const SizedBox(height: 15),
                    MetaDesWidget(),
                    const SizedBox(height: 15),
                    MetaKeyWidget(),
                    const SizedBox(height: 40),
                    Text(translate('auth:text_facebook_setup'), style: theme.textTheme.headline6),
                    const SizedBox(height: 20),
                    FaceBookTitleWidget(),
                    const SizedBox(height: 15),
                    FaceBookDesWidget(),
                    const SizedBox(height: 15),
                    const FacebookImage(),
                    const SizedBox(height: 40),
                    Text(translate('auth:text_twitter_setup'), style: theme.textTheme.headline6),
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
