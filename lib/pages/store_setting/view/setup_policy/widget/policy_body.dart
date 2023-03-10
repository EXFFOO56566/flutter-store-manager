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
import '../../multi_store_setup_register/view/policy_setup/field/cancel_policy.dart';
import '../../multi_store_setup_register/view/policy_setup/field/refund_policy.dart';
import '../../multi_store_setup_register/view/policy_setup/field/shipping_policy.dart';
import '../../multi_store_setup_register/view/policy_setup/field/tab_policy.dart';

//Themes
import 'package:flutter_store_manager/themes.dart';

class StoreSetupPolicyBody extends StatelessWidget with AppbarMixin, LoadingMixin {
  const StoreSetupPolicyBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    context.read<StoreSettingBloc>().add(const GetStoreSettingEvent());
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: baseStyleAppBar(
          title: translate('auth:text_setup_policy'),
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
                        context.read<StoreSettingBloc>().add(const SubmitStep3Event(isSingle: true));
                      },
                      child: (state.submitPolicyStatus == const LoadingState())
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
            );
          },
          listenWhen: (previous, current) => previous.submitPolicyStatus != current.submitPolicyStatus,
          listener: (context, state) {
            if (state.submitPolicyStatus == const LoadedState()) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(translate('common:text_success')),
              ));
            }
            if (state.submitPolicyStatus == const ErrorState()) {
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
