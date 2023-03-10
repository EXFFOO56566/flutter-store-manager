import 'package:flutter/material.dart';
import 'package:ui/widgets/container_secondary.dart';

class DeliveryUserInfo extends StatelessWidget {
  final String name;
  final Widget address;
  final Widget? email;
  final Widget? phone;

  const DeliveryUserInfo({
    Key? key,
    required this.name,
    required this.address,
    this.email,
    this.phone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return ContainerSecondary(
      borderRadius: BorderRadius.circular(8),
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: theme.textTheme.subtitle2),
            const SizedBox(height: 10),
            email ?? Container(),
            phone ?? Container(),
            address,
          ],
        ),
      ),
    );
  }
}
