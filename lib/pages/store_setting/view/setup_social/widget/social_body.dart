// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';
import 'package:flutter_store_manager/types/types.dart';

// Bloc
import '../../../bloc/store_setting_bloc.dart';

// View
import '../../multi_store_setup_register/view/social/field/facebook.dart';
import '../../multi_store_setup_register/view/social/field/google.dart';
import '../../multi_store_setup_register/view/social/field/insta.dart';
import '../../multi_store_setup_register/view/social/field/likedin.dart';
import '../../multi_store_setup_register/view/social/field/pinterest.dart';
import '../../multi_store_setup_register/view/social/field/snapchat.dart';
import '../../multi_store_setup_register/view/social/field/twitter.dart';
import '../../multi_store_setup_register/view/social/field/youtube.dart';

//Themes
import 'package:flutter_store_manager/themes.dart';

class StoreSetupSocialBody extends StatelessWidget with AppbarMixin, LoadingMixin {
  const StoreSetupSocialBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    ThemeData theme = Theme.of(context);
    context.read<StoreSettingBloc>().add(const GetStoreSettingEvent());

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: baseStyleAppBar(
          title: translate('auth:text_setup_social'),
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
                        context.read<StoreSettingBloc>().add(const SubmitStep6Event(isSingle: true));
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(100, 50),
                        minimumSize: const Size(0, 41),
                        padding: EdgeInsets.zero,
                        textStyle: theme.textTheme.button?.copyWith(fontSize: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: (state.submitSocialStatus == const LoadingState())
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
            );
          },
          listenWhen: (previous, current) => previous.submitSocialStatus != current.submitSocialStatus,
          listener: (context, state) {
            if (state.submitSocialStatus == const LoadedState()) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(translate('common:text_success')),
              ));
            }
            if (state.submitSocialStatus == const ErrorState()) {
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
