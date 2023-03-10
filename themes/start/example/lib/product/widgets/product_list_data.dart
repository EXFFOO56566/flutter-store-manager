import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ui/ui.dart';

import '../../widgets/product_item.dart';

class ProductListData extends StatelessWidget {
  const ProductListData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double width = mediaQuery.size.width;

    return Column(
      children: List.generate(10, (index) {
        return Slidable(
          key: ValueKey(index),
          endActionPane: ActionPane(
            extentRatio: 68 / width,
            motion: const ScrollMotion(),
            children: [
              Expanded(
                child: ButtonSlidable(
                  icon: CommunityMaterialIcons.trash_can_outline,
                  colorIcon: const Color(0xFFFF5200),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          child: const ProductItem(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            indentDivider: 125,
            endIndentDivider: 25,
          ),
        );
      }),
    );
  }
}
