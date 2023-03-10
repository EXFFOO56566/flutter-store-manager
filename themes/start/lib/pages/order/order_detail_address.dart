import 'package:flutter/material.dart';
import 'package:ui/widgets/container_secondary.dart';

class OrderDetailAddress extends StatelessWidget {
  final String name;
  final String address;
  final String? company;
  final Widget? email;
  final Widget? phone;
  final Widget? customerNote;

  const OrderDetailAddress({
    Key? key,
    required this.name,
    required this.address,
    this.email,
    this.phone,
    this.company,
    this.customerNote,
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
            Text(company ?? '', style: theme.textTheme.caption),
            Text(address, style: theme.textTheme.caption),
            email ?? Container(),
            phone ?? Container(),
            customerNote ?? Container(),
          ],
        ),
      ),
    );
  }
}
