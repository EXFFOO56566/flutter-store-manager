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
import '../../../update_store_payment/view/widgets/payment_form.dart';

//Themes
import 'package:flutter_store_manager/themes.dart';

class StoreSetupPayment extends StatelessWidget with AppbarMixin, LoadingMixin {
  final Function onNextStep;

  const StoreSetupPayment({
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
              title: translate('auth:text_second_payment'),
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
                  context.read<StoreSettingBloc>().add(const SubmitStep2Event());
                  onNextStep();
                },
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(25, 18, 25, 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PaymentForm(
                      method: state.paymentMethod ?? 'paypal',
                      storeSettingState: state,
                      changeMethod: (String value) {
                        context.read<StoreSettingBloc>().add(PaymentMethodChanged(value));
                      },
                    ),
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
