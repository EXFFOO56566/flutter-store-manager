import 'package:flutter/material.dart';
import 'package:flutter_store_manager/themes.dart';

class ProductSearchItem extends StatelessWidget {
  final Option? item;
  final GestureTapCallback? onTap;

  const ProductSearchItem({Key? key, this.item, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    bool loading = item?.key == null || item?.key == '0';
    return BoxDividerUi(
      child: ListTile(
        title: loading
            ? const AnimatedShimmer(width: 150, height: 24)
            : Text(item?.name ?? '', style: theme.textTheme.bodyText2),
        contentPadding: EdgeInsets.zero,
        onTap: loading ? null : onTap,
      ),
    );
  }
}
