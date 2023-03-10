import 'package:appcheap_flutter_core/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:country_repository/country_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/address/address.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:flutter_store_manager/types/types.dart';

class FieldState extends StatelessWidget {
  final Map field;
  final GetAddressFromScreen? fromScreen;
  final Color? borderColor;
  final bool isRequired;
  const FieldState({
    Key? key,
    required this.field,
    this.fromScreen,
    this.borderColor,
    this.isRequired = true,
  }) : super(key: key);

  List<StateData> getStateData(List<Country> countries, String code) {
    List<StateData> states = [];
    Country? country = countries.firstWhereOrNull((element) => element.code == code);
    if (country != null) {
      states.addAll(country.states);
    }
    return states;
  }

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;

    return BlocBuilder<AddressCubit, AddressState>(
      builder: (context, state) {
        String label = field['label'] ?? 'Field';
        bool required = field['required'] ?? false;
        List<StateData> states = getStateData(state.countries, _defineCountry(state, fromScreen) ?? '');

        if (states.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabelInput(title: label, isRequired: isRequired ? required : false),
              InputDropdown(
                value: _defineState(state, fromScreen),
                options: states
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
                          context.read<AddressCubit>().selectState(key);
                        }
                        break;
                      case GetAddressFromScreen.supportCustomer:
                        if (key != state.supportCodeCountrySelected) {
                          context.read<AddressCubit>().selectSupportState(key);
                        }
                        break;
                    }
                  } else {
                    if (key != state.codeCountrySelected) {
                      context.read<AddressCubit>().selectState(key);
                    }
                  }
                },
                hintText: translate('account:text_select_state'),
                hintTextSearchModal: translate('account:text_search_state'),
                borderColor: borderColor,
              ),
            ],
          );
        }
        return InputTextField(
          label: label,
          isRequired: isRequired ? required : false,
        );
      },
    );
  }

  _defineState(AddressState state, GetAddressFromScreen? fromScreen) {
    if (fromScreen != null) {
      switch (fromScreen) {
        case GetAddressFromScreen.setupInfo:
          return state.stateCode;
        case GetAddressFromScreen.supportCustomer:
          return state.supportStateCode;
      }
    } else {
      return state.stateCode;
    }
  }

  _defineCountry(AddressState state, GetAddressFromScreen? fromScreen) {
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
