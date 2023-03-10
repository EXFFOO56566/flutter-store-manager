// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'package:formz/formz.dart';

// Bloc
import '../../../../bloc/store_setting_bloc.dart';

// View
import 'payment_form.dart';

//Themes
import 'package:flutter_store_manager/themes.dart';

class StorePaymentForm extends StatefulWidget {
  const StorePaymentForm({
    Key? key,
  }) : super(key: key);

  @override
  StorePaymentFormState createState() => StorePaymentFormState();
}

class StorePaymentFormState extends State<StorePaymentForm> with LoadingMixin {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;

    return BlocConsumer<StoreSettingBloc, StoreSettingState>(
      builder: (context, state) {
        return Column(
          children: [
            PaymentForm(
              method: state.paymentMethod ?? 'paypal',
              storeSettingState: state,
              changeMethod: (String value) {
                context.read<StoreSettingBloc>().add(PaymentMethodChanged(value));
              },
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: state.statusUpdatePayment.isValidated
                    ? () {
                        if (!state.statusUpdatePayment.isSubmissionInProgress) {
                          FocusManager.instance.primaryFocus?.unfocus();
                          context.read<StoreSettingBloc>().add(const UpdatePaymentMethod());
                        }
                      }
                    : null,
                child: state.statusUpdatePayment.isSubmissionInProgress
                    ? buildLoadingElevated()
                    : Text(AppLocalizations.of(context)!.translate('common:text_button_save')),
              ),
            )
          ],
        );
      },
      listenWhen: (previous, current) => previous.statusUpdatePayment != current.statusUpdatePayment,
      listener: (context, state) {
        switch (state.statusUpdatePayment) {
          case FormzStatus.submissionSuccess:
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(translate('common:text_success')),
            ));
            break;
          case FormzStatus.submissionFailure:
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(translate('common:text_failure')),
            ));
            break;
          default:
            break;
        }
      },
    );
  }
}
