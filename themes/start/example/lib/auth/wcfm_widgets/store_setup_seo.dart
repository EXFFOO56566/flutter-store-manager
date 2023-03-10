import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../../widgets/select_image.dart';

class StoreSetupSeo extends StatelessWidget with AppbarMixin {
  final Function onNextStep;

  const StoreSetupSeo({
    Key? key,
    required this.onNextStep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: baseStyleAppBar(
        title: '5. SEO',
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
              Text('Store SEO setup', style: theme.textTheme.headline6),
              const SizedBox(height: 20),
              const InputTextField(label: 'SEO Title'),
              const SizedBox(height: 15),
              const InputTextField(
                label: 'Meta Description (should be less than 156 chars.)',
                maxLines: 5,
                maxLength: 156,
                decoration: InputDecoration(counterText: ''),
              ),
              const SizedBox(height: 15),
              const InputTextField(
                label: 'Meta Keywords',
                maxLines: 5,
              ),
              const SizedBox(height: 40),
              Text('Facebook Setup', style: theme.textTheme.headline6),
              const SizedBox(height: 20),
              const InputTextField(label: 'Facebook Title'),
              const SizedBox(height: 15),
              const InputTextField(
                label: 'Facebook Description',
                maxLines: 5,
                maxLength: 156,
                decoration: InputDecoration(counterText: ''),
              ),
              const SizedBox(height: 15),
              const SelectImage(label: 'Facebook Image'),
              const SizedBox(height: 40),
              Text('Twitter Setup', style: theme.textTheme.headline6),
              const SizedBox(height: 20),
              const InputTextField(label: 'Twitter Title'),
              const SizedBox(height: 15),
              const InputTextField(
                label: 'Twitter Description',
                maxLines: 5,
                maxLength: 156,
                decoration: InputDecoration(counterText: ''),
              ),
              const SizedBox(height: 15),
              const SelectImage(label: 'Twitter Image'),
            ],
          ),
        ),
      ),
    );
  }
}
