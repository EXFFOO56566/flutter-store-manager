import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class StoreSetupSocial extends StatelessWidget with AppbarMixin {
  final Function onNextStep;

  const StoreSetupSocial({
    Key? key,
    required this.onNextStep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: baseStyleAppBar(
        title: '6. Store Social setup',
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
              InputTextField(
                label: 'Twitter',
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    CommunityMaterialIcons.twitter,
                    size: 20,
                    color: theme.textTheme.overline?.color,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              InputTextField(
                label: 'Facebook',
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    CommunityMaterialIcons.facebook,
                    size: 20,
                    color: theme.textTheme.overline?.color,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              InputTextField(
                label: 'Instagram',
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    CommunityMaterialIcons.instagram,
                    size: 20,
                    color: theme.textTheme.overline?.color,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              InputTextField(
                label: 'Youtube',
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    CommunityMaterialIcons.youtube,
                    size: 20,
                    color: theme.textTheme.overline?.color,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              InputTextField(
                label: 'Linkedin',
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    CommunityMaterialIcons.linkedin,
                    size: 20,
                    color: theme.textTheme.overline?.color,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              InputTextField(
                label: 'Google Plus',
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    CommunityMaterialIcons.google_plus,
                    size: 20,
                    color: theme.textTheme.overline?.color,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              InputTextField(
                label: 'Snapchat',
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    CommunityMaterialIcons.snapchat,
                    size: 20,
                    color: theme.textTheme.overline?.color,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              InputTextField(
                label: 'Pinterest',
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    CommunityMaterialIcons.pinterest,
                    size: 20,
                    color: theme.textTheme.overline?.color,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
