import 'package:flutter/material.dart';

class RegisterContainer extends StatelessWidget {
  final Widget form;
  final Widget footer;

  const RegisterContainer({
    Key? key,
    required this.form,
    required this.footer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(25, 10, 25, 16),
          sliver: SliverToBoxAdapter(
            child: form,
          ),
        ),
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
