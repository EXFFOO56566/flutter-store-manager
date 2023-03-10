import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/address/address.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:flutter_store_manager/types/types.dart';

class FieldCountry extends StatelessWidget {
  final Map field;
  final GetAddressFromScreen? fromScreen;
  final Color? borderColor;
  final bool isRequired;
  const FieldCountry({
    Key? key,
    required this.field,
    this.fromScreen,
    this.borderColor,
    this.isRequired = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;

    return BlocBuilder<AddressCubit, AddressState>(
      builder: (context, state) {
        String label = field['label'] ?? 'Field';
        bool required = field['required'] ?? false;

        List<Option> options = state.countries
            .map((e) => Option(
                  key: e.code,
                  name: e.name,
                ))
            .toList()
            .cast<Option>();

        if (options.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabelInput(title: label, isRequired: isRequired == true ? required : false),
              InputDropdown(
                value: _defineValue(state, fromScreen),
                options: state.countries
                    .map((e) => Option(
                          key: e.code,
                          name: e.name,
                        ))
                    .toList()
                    .cast<Option>(),
                onChanged: (String key) {
                  if (fromScreen != null) {
                    switch (fromScreen!) {
                      case GetAddressFromScreen.setupInfo:
                        if (key != state.codeCountrySelected) {
                          context.read<AddressCubit>().selectCountry(key);
                        }
                        break;
                      case GetAddressFromScreen.supportCustomer:
                        if (key != state.supportCodeCountrySelected) {
                          context.read<AddressCubit>().selectSupportCountry(key);
                        }
                        break;
                    }
                  } else {
                    if (key != state.codeCountrySelected) {
                      context.read<AddressCubit>().selectCountry(key);
                    }
                  }
                },
                hintText: translate('account:text_select_country'),
                hintTextSearchModal: translate('account:text_search_country'),
                isSearchModal: true,
                isExpandModal: true,
                ratioHeightModal: 0.8,
                borderColor: borderColor,
              ),
            ],
          );
        }

        return InputTextField(
          label: label,
          isRequired: isRequired == true ? required : false,
        );
      },
    );
  }

  _defineValue(AddressState state, GetAddressFromScreen? fromScreen) {
    if (fromScreen != null) {
      switch (fromScreen) {
        case GetAddressFromScreen.setupInfo:
          return state.codeCountrySelected;
        case GetAddressFromScreen.supportCustomer:
          return state.supportCodeCountrySelected;
      }
    } else {
      return state.codeCountrySelected;
    }
  }
}
