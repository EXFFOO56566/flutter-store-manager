import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/address/bloc/address_cubit.dart';
import 'package:flutter_store_manager/address/widgets/field_country.dart';
import 'package:flutter_store_manager/address/widgets/field_state.dart';
import 'package:flutter_store_manager/address/widgets/field_text.dart';

class AddressForm extends StatelessWidget {
  final GetAddressFromScreen getAddressFromScreen;

  const AddressForm({
    Key? key,
    required this.getAddressFromScreen,
  }) : super(key: key);

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
    late AddressCubit cubit;
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        double widthSize =
            constraints.maxWidth != double.infinity ? constraints.maxWidth : MediaQuery.of(context).size.width;
        return BlocBuilder<AddressCubit, AddressState>(
          builder: (context, state) {
            cubit = context.read<AddressCubit>();
            bool isInitDataBilling = getAddressFromScreen == GetAddressFromScreen.setupInfo;
            Map fields = dataField(
                state.countryLocale,
                (getAddressFromScreen == GetAddressFromScreen.setupInfo)
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
                    isRequired: false,
                    fromScreen: getAddressFromScreen,
                    borderColor: Theme.of(context).focusColor,
                  );
                  break;
                case 'state':
                  child = FieldState(
                    field: fields[key],
                    isRequired: false,
                    fromScreen: getAddressFromScreen,
                    borderColor: Theme.of(context).focusColor,
                  );
                  break;
                default:
                  switch (key) {
                    case 'first_name':
                      child = FieldText(
                        field: fields[key],
                        isRequired: false,
                        initData: isInitDataBilling ? state.firstName : state.supportFirstName,
                        onChanged: (String value) {
                          switch (getAddressFromScreen) {
                            case GetAddressFromScreen.setupInfo:
                              cubit.changeFirstName(value);
                              break;
                            case GetAddressFromScreen.supportCustomer:
                              cubit.changeSupportFirstName(value);
                              break;
                          }
                        },
                      );
                      break;
                    case 'last_name':
                      child = FieldText(
                        isRequired: false,
                        field: fields[key],
                        initData: isInitDataBilling ? state.lastName : state.supportLastName,
                        onChanged: (String value) {
                          switch (getAddressFromScreen) {
                            case GetAddressFromScreen.setupInfo:
                              cubit.changeLastName(value);
                              break;
                            case GetAddressFromScreen.supportCustomer:
                              cubit.changeSupportLastName(value);
                              break;
                          }
                        },
                      );
                      break;
                    case 'address_1':
                      child = FieldText(
                        isRequired: false,
                        field: fields[key],
                        initData: isInitDataBilling ? state.address1 : state.supportAddress1,
                        onChanged: (String value) {
                          switch (getAddressFromScreen) {
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
                    case 'address_2':
                      child = FieldText(
                        field: fields[key],
                        initData: isInitDataBilling ? state.address2 : state.supportAddress2,
                        onChanged: (String value) {
                          switch (getAddressFromScreen) {
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
                    case 'city':
                      child = FieldText(
                        isRequired: false,
                        field: fields[key],
                        initData: isInitDataBilling ? state.city : state.supportCity,
                        onChanged: (String value) {
                          switch (getAddressFromScreen) {
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
                    case 'postcode':
                      child = FieldText(
                        isRequired: false,
                        field: fields[key],
                        initData: isInitDataBilling ? state.zip : state.supportZip,
                        onChanged: (String value) {
                          switch (getAddressFromScreen) {
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
              key: Key("$getAddressFromScreen"),
              spacing: 0,
              runSpacing: 15,
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: children,
            );
          },
        );
      },
    );
  }
}
