import 'package:flutter/material.dart';
import 'package:ui/constants/countries.dart' as list_countries;
import 'package:ui/models/phone_number.dart';
import 'package:ui/models/option.dart';

import 'modal_option.dart';

const String _defaultCountryCode = 'US';

enum InputPhoneNumberType { enable, disable, error }

class InputPhoneNumber extends StatefulWidget {
  final String? initialValue;
  final TextInputType keyboardType;
  final bool enabled;
  final bool autofocus;
  final TextInputAction? textInputAction;
  final ValueChanged<PhoneNumber>? onChanged;
  final String? hintText;
  final String? errorText;
  final String initCountryCode;
  final String? searchText;
  final EdgeInsetsGeometry? paddingViewCountry;

  const InputPhoneNumber({
    Key? key,
    this.initialValue,
    this.keyboardType = TextInputType.phone,
    this.enabled = true,
    this.autofocus = false,
    this.onChanged,
    this.textInputAction,
    this.hintText,
    this.errorText,
    this.initCountryCode = _defaultCountryCode,
    this.searchText,
    this.paddingViewCountry,
  }) : super(key: key);

  @override
  State<InputPhoneNumber> createState() => _InputPhoneNumberState();
}

class _InputPhoneNumberState extends State<InputPhoneNumber> {
  late Map<String, String> _selectedCountry;
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void didChangeDependencies() {
    String initialCountryCode = _getInit(list_countries.countries, widget.initCountryCode);

    Map<String, String> init = list_countries.countries[0];

    Map<String, String> selectedCountry = list_countries.countries
        .firstWhere((item) => item['code']?.toUpperCase() == initialCountryCode.toUpperCase(), orElse: () => init);

    setState(() {
      _selectedCountry = selectedCountry;
    });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _controller = TextEditingController(text: widget.initialValue ?? '');
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void clickCountry(BuildContext context) async {
    List<Option> options =
        list_countries.countries.map((e) => Option(key: e['code'] ?? '', name: e['name'] ?? '')).toList();

    String? value = await showModalBottomSheet<String?>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        MediaQueryData mediaQuery = MediaQuery.of(context);
        double height = mediaQuery.size.height - mediaQuery.viewInsets.top - mediaQuery.viewInsets.bottom;

        return Container(
          constraints: BoxConstraints(maxHeight: height - (mediaQuery.size.height * 0.2)),
          margin: mediaQuery.viewInsets,
          child: ModalOption(
            options: options,
            value: _selectedCountry['code'],
            onChanged: (String value) => Navigator.pop(context, value),
            isExpand: true,
            isSearch: true,
            hintTextSearch: widget.searchText ?? '',
          ),
        );
      },
    );

    if (value != null && _selectedCountry['code'] != value) {
      dynamic country = list_countries.countries
          .firstWhere((item) => item['code']?.toUpperCase() == value.toUpperCase(), orElse: () => _selectedCountry);

      PhoneNumber newPhoneNumber = PhoneNumber(
        countryISOCode: country['code'],
        countryCode: country['dial_code'],
        number: _controller.text.replaceAll(_selectedCountry['dial_code'] ?? '', ''),
      );
      setState(() {
        _selectedCountry = country;
      });
      widget.onChanged?.call(newPhoneNumber);
    }
  }

  Widget buildCountry(BuildContext context, ThemeData theme) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        if (_focusNode.hasFocus == false) {
          _focusNode.unfocus();
          _focusNode.canRequestFocus = false;
        }
      },
      child: Padding(
        padding: widget.paddingViewCountry ?? const EdgeInsetsDirectional.only(start: 18, end: 13),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkResponse(
              onTap: () => clickCountry(context),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _selectedCountry['flag'] ?? '',
                    style: const TextStyle(fontSize: 18),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 14,
                    color: theme.textTheme.caption?.color,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 11),
            Text(_selectedCountry['dial_code'] ?? '+', style: theme.textTheme.bodyText2),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return TextFormField(
      controller: _controller,
      focusNode: _focusNode,
      keyboardType: widget.keyboardType,
      autofocus: widget.autofocus,
      enabled: widget.enabled,
      textInputAction: widget.textInputAction,
      decoration: InputDecoration(
          prefixIcon: buildCountry(context, theme), hintText: widget.hintText, errorText: widget.errorText),
      onChanged: (value) {
        if (value.startsWith("+") && value.length > 2 && value.length < 5) {
          setState(() {
            _selectedCountry = list_countries.countries
                .firstWhere((item) => item['dial_code']?.startsWith(value) == true, orElse: () => _selectedCountry);
          });
        }

        if (widget.onChanged != null) {
          widget.onChanged!(
            PhoneNumber(
              countryISOCode: _selectedCountry['code'],
              countryCode: _selectedCountry['dial_code'],
              number: value,
            ),
          );
        }
      },
    );
  }
}

String _getInit(List<Map<String, String>> allCountries, String value) {
  if (value.isEmpty || allCountries.isEmpty) {
    return _defaultCountryCode;
  }
  bool checkExist = allCountries.indexWhere((element) => element['code']?.toUpperCase() == value.toUpperCase()) > -1;
  if (checkExist) {
    return value;
  }
  return allCountries[0]['code']!;
}
