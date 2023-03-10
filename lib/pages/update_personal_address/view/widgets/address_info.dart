import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:customers_repository/customers_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/address/bloc/address_cubit.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'package:flutter_store_manager/themes.dart';

import '../../bloc/update_personal_address_bloc.dart';
import 'address_form.dart';

class AddressInfo extends StatefulWidget {
  final Function(Customers address)? onChangedBilling;
  final Function(Customers address)? onChangedShipping;
  final Function(bool)? onChangedSameAdBilling;
  final bool? enableShipping;

  const AddressInfo({
    Key? key,
    this.onChangedBilling,
    this.onChangedShipping,
    this.onChangedSameAdBilling,
    this.enableShipping,
  }) : super(key: key);

  @override
  State<AddressInfo> createState() => _AddressInfoState();
}

class _AddressInfoState extends State<AddressInfo> with LoadingMixin {
  late AddressCubit cubit;
  late UpdatePersonalAddressBloc bloc;
  bool enableShipping = true;
  bool _isExpandedShip = false;
  bool _isExpandedBill = true;
  bool enableInitData = false;
  @override
  void initState() {
    super.initState();
    cubit = context.read<AddressCubit>();
    bloc = context.read<UpdatePersonalAddressBloc>();
    enableShipping = widget.enableShipping!;
    enableInitData = true;
  }

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    return SingleChildScrollView(
      key: UniqueKey(),
      padding: const EdgeInsets.fromLTRB(25, 8, 25, 15),
      child: BlocBuilder<AddressCubit, AddressState>(
        builder: (context, state) {
          if (widget.onChangedBilling != null) {
            widget.onChangedBilling!(Customers(
              firstName: state.firstName,
              lastName: state.lastName,
              country: state.codeCountrySelected,
              address1: state.address1,
              address2: state.address2,
              city: state.city,
              state: state.stateCode,
              postCode: state.zip,
            ));
          }
          if (widget.onChangedShipping != null) {
            widget.onChangedShipping!(Customers(
              firstName: state.supportFirstName,
              lastName: state.supportLastName,
              country: state.supportCodeCountrySelected,
              address1: state.supportAddress1,
              address2: state.supportAddress2,
              city: state.supportCity,
              state: state.supportStateCode,
              postCode: state.supportZip,
            ));
          }
          return BlocBuilder<UpdatePersonalAddressBloc, UpdatePersonalAddressState>(
            builder: (context, state) {
              if (widget.onChangedSameAdBilling != null) {
                widget.onChangedSameAdBilling!(enableShipping);
              }

              return Column(
                children: [
                  buildExpansion(
                    child: const AddressForm(getAddressFromScreen: GetAddressFromScreen.setupInfo),
                    onExpansionChanged: (value) {
                      setState(() {
                        _isExpandedBill = value;
                      });
                      bloc.add(EnableButtonEvent(value, _isExpandedShip));
                    },
                    isExpanded: _isExpandedBill,
                    title: translate('order:text_billing_address'),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: LabelInput(
                      title: translate('order:text_same_as_billing'),
                      padding: const EdgeInsets.only(top: 0.5),
                    ),
                    trailing: CupertinoSwitch(
                      value: enableShipping,
                      onChanged: (value) {
                        if (_isExpandedBill == false) {
                          bloc.add(const EnableButtonEvent(false, false));
                        }
                        setState(() {
                          _isExpandedShip = false;
                          enableShipping = value;
                        });
                      },
                    ),
                  ),
                  if (enableShipping == false)
                    buildExpansion(
                      child: const AddressForm(getAddressFromScreen: GetAddressFromScreen.supportCustomer),
                      onExpansionChanged: (value) {
                        setState(() {
                          _isExpandedShip = value;
                        });
                        bloc.add(EnableButtonEvent(value, _isExpandedBill));
                      },
                      isExpanded: _isExpandedShip,
                      title: translate('order:text_shipping_address'),
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget buildExpansion({
    required Widget child,
    Function(bool)? onExpansionChanged,
    required bool isExpanded,
    String? title,
  }) {
    return ExpansionView(
      title: LabelInput(
        title: title ?? '',
        isLarge: true,
        padding: const EdgeInsets.only(top: 0.5),
      ),
      initiallyExpanded: isExpanded ? true : false,
      onExpansionChanged: onExpansionChanged,
      childrenPadding: const EdgeInsets.only(top: 10),
      children: [child],
    );
  }
}
