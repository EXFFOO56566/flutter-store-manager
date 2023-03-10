import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/address/address.dart';

import 'field_country.dart';
import 'field_state.dart';
import 'field_text.dart';

class AddressFormBody extends StatefulWidget {
  const AddressFormBody({Key? key}) : super(key: key);

  @override
  AddressFormBodyState createState() => AddressFormBodyState();
}

class AddressFormBodyState extends State<AddressFormBody> {
  late AddressCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<AddressCubit>();
    cubit.init();
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
      if (a.colorHex['hidden'] != true) {
        result[a.key] = a.colorHex;
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        double widthSize =
            constraints.maxWidth != double.infinity ? constraints.maxWidth : MediaQuery.of(context).size.width;
        return BlocBuilder<AddressCubit, AddressState>(
          builder: (context, state) {
            if (cubit.loading) {
              return const Text('Loading');
            }

            Map fields = dataField(state.countryLocale, state.codeCountrySelected ?? '');

            List listKey = fields.keys.toList();

            return Wrap(
              spacing: 0,
              runSpacing: 15,
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: List.generate(listKey.length, (index) {
                String key = listKey[index];

                dynamic classItem = fields[key]['class'] ?? [];

                String type = fields[key]['type'] ?? '';

                late Widget child;

                switch (type) {
                  case 'country':
                    child = FieldCountry(
                      field: fields[key],
                    );
                    break;
                  case 'state':
                    child = FieldState(
                      field: fields[key],
                    );
                    break;

                  default:
                    child = FieldText(
                      field: fields[key],
                    );
                }

                bool isFullWidth = classItem is List && classItem.contains('form-row-wide') ? true : false;
                double widthItem = !isFullWidth ? (widthSize - 12) / 2 : widthSize;

                return SizedBox(width: widthItem, child: child);
              }),
            );
          },
        );
      },
    );
  }
}
