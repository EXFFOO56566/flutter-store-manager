import 'package:flutter/material.dart';
import 'package:ui/items/items.dart';

class VariationItemUi extends StatelessWidget {
  final Widget title;
  final Widget? attribute;
  final Widget buttonDelete;

  const VariationItemUi({
    Key? key,
    required this.title,
    this.attribute,
    required this.buttonDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BoxDividerUi(
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [title],
        ),
        subtitle: attribute != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [attribute!],
              )
            : null,
        horizontalTitleGap: 0,
        contentPadding: EdgeInsets.zero,
        trailing: buttonDelete,
      ),
    );
  }
}
