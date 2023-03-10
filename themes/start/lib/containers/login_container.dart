import 'package:flutter/material.dart';

class LoginContainer extends StatelessWidget {
  final Widget heading;
  final Widget form;
  final Widget? footer;
  final Widget socials;
  final String? subtitleLogin;

  const LoginContainer({
    Key? key,
    required this.heading,
    required this.form,
    required this.socials,
    this.footer,
    this.subtitleLogin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(25, 84, 25, 16),
          sliver: SliverToBoxAdapter(
            child: Column(
              children: [
                heading,
                const SizedBox(height: 40),
                form,
                const SizedBox(height: 23),
                Text(subtitleLogin ?? 'or login with', style: theme.textTheme.caption),
                const SizedBox(height: 20),
                socials,
              ],
            ),
          ),
        ),
        if (footer != null)
          SliverFillRemaining(
            hasScrollBody: false,
            fillOverscroll: true,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 32, top: 16),
                child: footer,
              ),
            ),
          )
      ],
    );
  }
}
