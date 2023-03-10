import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../../widgets/select_image.dart';

List<Option> _countries = const [
  Option(key: 'us', name: 'United State'),
  Option(key: 'uk', name: 'United Kingdom'),
  Option(key: 'vn', name: 'Viet Nam'),
];

class StoreSetupInfo extends StatelessWidget with AppbarMixin {
  final Function onNextStep;

  const StoreSetupInfo({
    Key? key,
    required this.onNextStep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseStyleAppBar(
        title: '1. Store setup',
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
          padding: const EdgeInsets.fromLTRB(25, 8, 25, 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SelectImage(label: 'Store Logo'),
              const SizedBox(height: 15),
              const SelectImage(label: 'Banner size is (1650x350) pixels.'),
              const SizedBox(height: 15),
              const InputTextField(label: 'Shop Name'),
              const SizedBox(height: 15),
              const InputTextField(label: 'Store Email'),
              const SizedBox(height: 15),
              const LabelInput(title: 'Phone Number'),
              const InputPhoneNumber(initCountryCode: 'vn', hintText: '- - - - - - - - -'),
              const SizedBox(height: 15),
              const InputTextField(label: 'Store Address 1'),
              const SizedBox(height: 15),
              const InputTextField(label: 'Store Address 2'),
              const SizedBox(height: 15),
              const InputTextField(label: 'Store City/Town'),
              const SizedBox(height: 15),
              const InputTextField(label: 'Store Postcode/Zip'),
              const SizedBox(height: 15),
              const LabelInput(title: 'Store Country *'),
              InputDropdown(
                hintText: "Select Country",
                hintTextSearchModal: 'Search country',
                options: _countries,
                onChanged: (_) {},
                isExpandModal: true,
                ratioHeightModal: 0.8,
                isSearchModal: true,
              ),
              const SizedBox(height: 15),
              const InputTextField(label: 'Store State/County *'),
              const SizedBox(height: 15),
              const InputTextField(
                label: 'Shop Description',
                minLines: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
