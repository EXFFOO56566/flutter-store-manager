import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

List<Option> _countries = const [
  Option(key: 'us', name: 'United State'),
  Option(key: 'uk', name: 'United Kingdom'),
  Option(key: 'vn', name: 'Viet Nam'),
];

class StoreSetupSupport extends StatelessWidget with AppbarMixin {
  final Function onNextStep;

  const StoreSetupSupport({
    Key? key,
    required this.onNextStep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseStyleAppBar(
        title: '4. Support setup',
        automaticallyImplyLeading: false,
      ),
      body: FixedBottom(
        bottom: StoreSetupBottom(
          textButtonSecondary: 'Skip this step',
          textButtonPrimary: 'Continue',
          onPressedSecondary: () => onNextStep(),
          onPressedPrimary: () => onNextStep(),
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(25, 18, 25, 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LabelInput(title: 'Phone Number '),
              const InputPhoneNumber(
                initCountryCode: 'vn',
                hintText: '- - - - - - - - -',
              ),
              const SizedBox(height: 15),
              const InputTextField(label: 'Email'),
              const SizedBox(height: 15),
              const InputTextField(label: 'Address 1'),
              const SizedBox(height: 15),
              const InputTextField(label: 'Address 2'),
              const SizedBox(height: 15),
              const LabelInput(title: 'Country'),
              InputDropdown(
                hintText: "Store Country",
                hintTextSearchModal: 'Search country',
                options: _countries,
                onChanged: (_) {},
                isExpandModal: true,
                ratioHeightModal: 0.8,
                isSearchModal: true,
              ),
              const SizedBox(height: 15),
              const InputTextField(label: 'City/Town'),
              const SizedBox(height: 15),
              const InputTextField(label: 'State/County'),
              const SizedBox(height: 15),
              const InputTextField(label: 'Postcode/Zip'),
            ],
          ),
        ),
      ),
    );
  }
}
