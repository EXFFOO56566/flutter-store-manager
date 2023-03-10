import 'package:example/screens/store_setup/bloc/store_setting_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'payment_form.dart';

class StorePaymentForm extends StatefulWidget {
  const StorePaymentForm({
    Key? key,
  }) : super(key: key);

  @override
  State<StorePaymentForm> createState() => _StorePaymentFormState();
}

class _StorePaymentFormState extends State<StorePaymentForm> {
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
                    ? const CupertinoActivityIndicator(color: Colors.white)
                    : const Text("Save"),
              ),
            )
          ],
        );
      },
      listenWhen: (previous, current) => previous.statusUpdatePayment != current.statusUpdatePayment,
      listener: (context, state) {
        switch (state.statusUpdatePayment) {
          case FormzStatus.submissionSuccess:
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Success"),
            ));
            break;
          case FormzStatus.submissionFailure:
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Failure"),
            ));
            break;
          default:
            break;
        }
      },
    );
  }
}
