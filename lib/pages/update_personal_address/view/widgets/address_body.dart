import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:customers_repository/customers_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_store_manager/themes.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'package:formz/formz.dart';
import 'package:flutter_store_manager/address/bloc/address_cubit.dart';
import '../../bloc/update_personal_address_bloc.dart';

import 'address_info.dart';

class AddressBody extends StatefulWidget {
  const AddressBody({Key? key}) : super(key: key);

  @override
  State<AddressBody> createState() => _AddressBodyState();
}

class _AddressBodyState extends State<AddressBody> with LoadingMixin {
  late AddressCubit cubit;
  late UpdatePersonalAddressBloc bloc;
  bool enableInitData = true;
  Customers billing = Customers();
  Customers shipping = Customers();
  bool enableShipping = true;
  @override
  void initState() {
    super.initState();
    cubit = context.read<AddressCubit>();
    bloc = context.read<UpdatePersonalAddressBloc>();
    cubit.getCountryLocale();
    cubit.getCountries();
    bloc.add(const GetUpdatePersonalAddressEvent());
  }

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    return BlocConsumer<UpdatePersonalAddressBloc, UpdatePersonalAddressState>(
      listenWhen: (previous, current) => previous.statusSaveAddress != current.statusSaveAddress,
      listener: (context, state) {
        switch (state.statusSaveAddress) {
          case FormzStatus.submissionSuccess:
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(translate('common:text_success')),
            ));
            break;
          case FormzStatus.submissionFailure:
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(translate('common:text_failure')),
              ),
            );
            break;
          default:
            break;
        }
      },
      builder: (context, state) {
        if (state.billing?.toJson() == null && state.shipping?.toJson() == null) {
          return Center(
            child: buildLoading(),
          );
        }
        if (state.enableInitData) {
          cubit.initAddress(billing: state.billing!, shipping: state.shipping!);
        }
        return FixedBottom(
          bottom: state.enableButtonBilling == true || state.enableButtonShipping == true
              ? ElevatedButton(
                  onPressed: state.statusSaveAddress.isValidated
                      ? () {
                          if (!state.statusSaveAddress.isSubmissionInProgress) {
                            FocusManager.instance.primaryFocus?.unfocus();
                            bloc.add(EnableShippingEvent(enableShipping));
                            bloc.add(SubmitAddressEvent(billing, shipping));
                          }
                        }
                      : null,
                  child: state.statusSaveAddress.isSubmissionInProgress
                      ? buildLoadingElevated()
                      : Text(AppLocalizations.of(context)!.translate('common:text_button_save')),
                )
              : const SizedBox(),
          paddingBottom: const EdgeInsets.all(25),
          child: AddressInfo(
            onChangedBilling: (value) => billing = value,
            onChangedShipping: (value) => shipping = value,
            onChangedSameAdBilling: (value) => enableShipping = value,
            enableShipping: state.enableShipping,
          ),
        );
      },
    );
  }
}
