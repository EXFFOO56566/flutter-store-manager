import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

List<Option> _countries = const [
  Option(key: 'us', name: 'United State'),
  Option(key: 'uk', name: 'United Kingdom'),
  Option(key: 'vn', name: 'Viet Nam'),
];

class AddressForm extends StatefulWidget {
  final Map<String, dynamic> data;
  final Function(String key, String value) changeData;
  final EdgeInsetsGeometry? padding;
  final bool isName;

  const AddressForm({
    Key? key,
    required this.data,
    required this.changeData,
    this.padding,
    this.isName = true,
  }) : super(key: key);

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  @override
  Widget build(BuildContext context) {
    String initFirstName = widget.data['firstName'] ?? '';
    String initLastName = widget.data['lastName'] ?? '';
    String initAddress1 = widget.data['address1'] ?? '';
    String initAddress2 = widget.data['address2'] ?? '';
    String? valueCountry = widget.data['country'];
    String initCity = widget.data['city'] ?? '';
    String initState = widget.data['state'] ?? '';
    String initPostcode = widget.data['postcode'] ?? '';

    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.isName) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: InputTextField(
                    label: 'First Name',
                    initialValue: initFirstName,
                    onChanged: (String value) => widget.changeData('firstName', value),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InputTextField(
                    label: 'Last Name',
                    initialValue: initLastName,
                    onChanged: (String value) => widget.changeData('lastName', value),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
          ],
          InputTextField(
            label: 'Address 1',
            initialValue: initAddress1,
            onChanged: (String value) => widget.changeData('address1', value),
          ),
          const SizedBox(height: 15),
          InputTextField(
            label: 'Address 2',
            initialValue: initAddress2,
            onChanged: (String value) => widget.changeData('address2', value),
          ),
          const SizedBox(height: 15),
          const LabelInput(title: 'Country'),
          InputDropdown(
            hintText: "Select Country",
            hintTextSearchModal: 'Search country',
            value: valueCountry,
            options: _countries,
            onChanged: (String value) => widget.changeData('country', value),
            isExpandModal: true,
            ratioHeightModal: 0.8,
            isSearchModal: true,
          ),
          const SizedBox(height: 15),
          InputTextField(
            label: 'City/Town',
            initialValue: initCity,
            onChanged: (String value) => widget.changeData('city', value),
          ),
          const SizedBox(height: 15),
          InputTextField(
            label: 'State/County',
            initialValue: initState,
            onChanged: (String value) => widget.changeData('state', value),
          ),
          const SizedBox(height: 15),
          InputTextField(
            label: 'Postcode/Zip',
            initialValue: initPostcode,
            onChanged: (String value) => widget.changeData('postcode', value),
          ),
        ],
      ),
    );
  }
}
