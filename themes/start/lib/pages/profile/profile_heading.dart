import 'package:flutter/material.dart';
import 'package:ui/widgets/container_secondary.dart';

class ProfileHeading extends StatelessWidget {
  final Widget avatar;
  final Widget name;
  final Widget logoutIcon;

  const ProfileHeading({
    Key? key,
    required this.avatar,
    required this.name,
    required this.logoutIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContainerSecondary(
      padding: const EdgeInsets.all(20),
      borderRadius: BorderRadius.circular(10),
      child: Row(
        children: [
          avatar,
          const SizedBox(width: 20),
          Expanded(child: name),
          const SizedBox(width: 12),
          logoutIcon,
        ],
      ),
    );
  }
}
