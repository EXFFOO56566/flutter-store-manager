import 'package:flutter/cupertino.dart';
import 'package:ui/ui.dart';

class FieldStockSwitch extends StatelessWidget {
  const FieldStockSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Flexible(
          child: LabelInput(
            title: 'Manager Stock',
            padding: EdgeInsets.zero,
          ),
        ),
        const SizedBox(width: 16),
        CupertinoSwitch(value: true, onChanged: (_) {})
      ],
    );
  }
}
