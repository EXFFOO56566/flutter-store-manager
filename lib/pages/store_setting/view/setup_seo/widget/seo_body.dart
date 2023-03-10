// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';
import 'package:flutter_store_manager/types/types.dart';

// Repository packages

// Bloc
import '../../../bloc/store_setting_bloc.dart';

// View
import '../../multi_store_setup_register/view/seo/field/face_des.dart';
import '../../multi_store_setup_register/view/seo/field/facebook_title.dart';
import '../../multi_store_setup_register/view/seo/field/meta_des.dart';
import '../../multi_store_setup_register/view/seo/field/meta_key.dart';
import '../../multi_store_setup_register/view/seo/field/seo_title.dart';
import '../../multi_store_setup_register/view/seo/field/twitter_des.dart';
import '../../multi_store_setup_register/view/seo/field/twitter_title.dart';
import '../../update_store_info/view/widgets/facebook_image.dart';
import '../../update_store_info/view/widgets/twitter_image.dart';

//Themes
import 'package:flutter_store_manager/themes.dart';

class StoreSetupSeoBody extends StatelessWidget with AppbarMixin, LoadingMixin {
  const StoreSetupSeoBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;
    context.read<StoreSettingBloc>().add(const GetStoreSettingEvent());
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: baseStyleAppBar(
          title: translate('auth:text_setup_seo'),
        ),
        body: BlocConsumer<StoreSettingBloc, StoreSettingState>(
          builder: (context, state) {
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
                        context.read<StoreSettingBloc>().add(const SubmitStep5Event(isSingle: true));
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(100, 50),
                        minimumSize: const Size(0, 41),
                        padding: EdgeInsets.zero,
                        textStyle: theme.textTheme.button?.copyWith(fontSize: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: (state.submitSeoStatus == const LoadingState())
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
            );
          },
          listenWhen: (previous, current) => previous.submitSeoStatus != current.submitSeoStatus,
          listener: (context, state) {
            if (state.submitSeoStatus == const LoadedState()) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(translate('common:text_success')),
              ));
            }
            if (state.submitSeoStatus == const ErrorState()) {
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
