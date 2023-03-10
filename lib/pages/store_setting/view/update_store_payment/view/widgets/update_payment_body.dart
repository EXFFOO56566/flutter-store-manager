// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';

// Repository packages

// Bloc
import 'package:flutter_store_manager/pages/store_setting/bloc/store_setting_bloc.dart';

// View
import 'store_payment_form.dart';

//Themes
import 'package:flutter_store_manager/themes.dart';

class UpdateStorePaymentBody extends StatelessWidget with AppbarMixin, LoadingMixin {
  const UpdateStorePaymentBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<StoreSettingBloc>().add(const GetStoreSettingEvent());
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: baseStyleAppBar(title: AppLocalizations.of(context)!.translate('account:text_update_payment')),
        body: BlocBuilder<StoreSettingBloc, StoreSettingState>(
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
            return const SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(25, 10, 25, 25),
              child: StorePaymentForm(),
            );
          },
        ),
      ),
    );
  }
}
