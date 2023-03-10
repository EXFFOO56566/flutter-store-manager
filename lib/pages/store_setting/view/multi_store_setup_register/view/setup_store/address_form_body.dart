// Flutter library
import 'package:flutter/material.dart';

// Repository packages
import 'package:store_setting_repository/store_setting_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Bloc
import 'package:flutter_store_manager/address/address.dart';

// View
import 'package:flutter_store_manager/address/widgets/field_country.dart';
import 'package:flutter_store_manager/address/widgets/field_state.dart';
import 'package:flutter_store_manager/address/widgets/field_text.dart';

//Themes

import 'package:flutter_store_manager/themes.dart';

class AddressFormStoreSetup extends StatefulWidget {
  const AddressFormStoreSetup({
    Key? key,
    this.currentAddress,
    this.onChangedStateSetup,
    this.onChangedStateSupport,
    this.supportAddress,
    required this.fromScreen,
  }) : super(key: key);
  final Address? currentAddress;
  final Address? supportAddress;
  final GetAddressFromScreen fromScreen;
  final Function(Address address)? onChangedStateSetup;
  final Function(Address address)? onChangedStateSupport;

  @override
  AddressFormStoreSetupState createState() => AddressFormStoreSetupState();
}

class AddressFormStoreSetupState extends State<AddressFormStoreSetup> with LoadingMixin {
  late AddressCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<AddressCubit>();
    cubit.initAddress(address: widget.currentAddress, supportAddress: widget.supportAddress);
  }

  Map dataField(Map dataLocale, String country) {
    Map data = {};
    if (dataLocale.isNotEmpty) {
      data.addAll(dataLocale['default']);
      final fieldCountry = dataLocale[country];
      if (fieldCountry is Map) {
        fieldCountry.forEach((key, value) {
          if (data.containsKey(key)) {
            data.update(key, (valueKey) {
              if (value is Map && valueKey is Map) {
                return {
                  ...valueKey,
                  ...value,
                };
              }
              return valueKey;
            });
          }
        });
      }
    }
    List arrData = data.entries.toList()..sort((a, b) => a.value['priority'] > b.value['priority'] ? 1 : 0);
    Map result = {};
    for (var a in arrData) {
      if (a.value['hidden'] != true) {
        result[a.key] = a.value;
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    cubit.initAddress(address: widget.currentAddress, supportAddress: widget.supportAddress);
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        double widthSize =
            constraints.maxWidth != double.infinity ? constraints.maxWidth : MediaQuery.of(context).size.width;
        return BlocBuilder<AddressCubit, AddressState>(builder: (context, state) {
          if (widget.onChangedStateSetup != null) {
            widget.onChangedStateSetup!(Address(
              street1: state.address1 ?? "",
              street2: state.address2 ?? "",
              city: state.city ?? "",
              zip: state.zip ?? "",
              country: state.codeCountrySelected ?? "",
              state: state.stateCode ?? "",
            ));
          }
          if (widget.onChangedStateSupport != null) {
            widget.onChangedStateSupport!(Address(
              street1: state.supportAddress1 ?? "",
              street2: state.supportAddress2 ?? "",
              city: state.supportCity ?? "",
              zip: state.supportZip ?? "",
              country: state.supportCodeCountrySelected ?? "",
              state: state.supportStateCode ?? "",
            ));
          }
          if (cubit.loading) {
            return SizedBox(
              height: 100,
              child: Center(child: buildLoading()),
            );
          }
          Map fields = dataField(
              state.countryLocale,
              (widget.fromScreen == GetAddressFromScreen.setupInfo)
                  ? (state.codeCountrySelected ?? '')
                  : (state.supportCodeCountrySelected ?? ''));
          List listKey = fields.keys.toList();

          final List<Widget> children = [];

          for (var key in listKey) {
            dynamic classItem = fields[key]['class'] ?? [];

            String type = fields[key]['type'] ?? '';
            Widget? child;

            switch (type) {
              case 'country':
                child = FieldCountry(
                  field: fields[key],
                  fromScreen: widget.fromScreen,
                );
                break;
              case 'state':
                child = FieldState(
                  field: fields[key],
                  fromScreen: widget.fromScreen,
                );
                break;
              default:
                switch (key) {
                  case "address_1":
                    child = FieldText(
                      field: fields[key],
                      initData: (widget.fromScreen == GetAddressFromScreen.setupInfo)
                          ? state.address1
                          : state.supportAddress1,
                      onChanged: (String value) {
                        switch (widget.fromScreen) {
                          case GetAddressFromScreen.setupInfo:
                            cubit.changeAddress1(value);
                            break;
                          case GetAddressFromScreen.supportCustomer:
                            cubit.changeSupportAddress1(value);
                            break;
                        }
                      },
                    );
                    break;
                  case "address_2":
                    child = FieldText(
                      field: fields[key],
                      initData: (widget.fromScreen == GetAddressFromScreen.setupInfo)
                          ? state.address2
                          : state.supportAddress2,
                      onChanged: (String value) {
                        switch (widget.fromScreen) {
                          case GetAddressFromScreen.setupInfo:
                            cubit.changeAddress2(value);
                            break;
                          case GetAddressFromScreen.supportCustomer:
                            cubit.changeSupportAddress2(value);
                            break;
                        }
                      },
                    );
                    break;
                  case "city":
                    child = FieldText(
                      field: fields[key],
                      initData: (widget.fromScreen == GetAddressFromScreen.setupInfo) ? state.city : state.supportCity,
                      onChanged: (String value) {
                        switch (widget.fromScreen) {
                          case GetAddressFromScreen.setupInfo:
                            cubit.changeCity(value);
                            break;
                          case GetAddressFromScreen.supportCustomer:
                            cubit.changeSupportCity(value);
                            break;
                        }
                      },
                    );
                    break;
                  case "postcode":
                    child = FieldText(
                      field: fields[key],
                      initData: (widget.fromScreen == GetAddressFromScreen.setupInfo) ? state.zip : state.supportZip,
                      onChanged: (String value) {
                        switch (widget.fromScreen) {
                          case GetAddressFromScreen.setupInfo:
                            cubit.changeZip(value);
                            break;
                          case GetAddressFromScreen.supportCustomer:
                            cubit.changeSupportZip(value);
                            break;
                        }
                      },
                    );
                    break;
                }
            }

            bool isFullWidth = classItem is List && classItem.contains('form-row-wide') ? true : false;
            double widthItem = !isFullWidth ? (widthSize - 12) / 2 : widthSize;

            if (child != null) {
              children.add(SizedBox(key: Key(key), width: widthItem, child: child));
            }
          }
          return Wrap(
            spacing: 0,
            runSpacing: 15,
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: children,
          );
        });
      },
    );
  }
}
