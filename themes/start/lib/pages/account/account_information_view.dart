import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class AccountInformationView extends StatelessWidget {
  final Widget avatar;
  final Widget firstName;
  final Widget lastName;
  final Widget email;

  const AccountInformationView({
    Key? key,
    required this.avatar,
    required this.firstName,
    required this.lastName,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContainerSecondary(
      borderRadius: BorderRadius.circular(10),
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          avatar,
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                firstName,
                const SizedBox(height: 15),
                lastName,
                const SizedBox(height: 15),
                email,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
