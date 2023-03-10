import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:ui/constants/constants.dart';

class ProductListButtonAdd extends StatelessWidget {
  final VoidCallback onPressed;

  const ProductListButtonAdd({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: theme.primaryColor,
        boxShadow: forthShadow,
      ),
      child: IconButton(
        icon: const Icon(CommunityMaterialIcons.plus_thick),
        iconSize: 16,
        color: theme.colorScheme.onPrimary,
        onPressed: onPressed,
        splashRadius: 20,
        padding: EdgeInsets.zero,
      ),
    );
  }
}
