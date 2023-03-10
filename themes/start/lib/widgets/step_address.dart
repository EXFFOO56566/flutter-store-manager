import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

enum StepPosition { start, middle, end }

class StepAddress extends StatelessWidget {
  final List<String> address;
  const StepAddress({
    Key? key,
    required this.address,
  }) : super(key: key);

  Widget buildIcon(StepPosition position) {
    if (position == StepPosition.start) {
      return Column(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(color: Color(0xFF00BA51), shape: BoxShape.circle),
          ),
          const SizedBox(height: 10),
          const SizedBox(
            height: 30,
            child: VerticalDivider(
              width: 1,
              thickness: 1,
            ),
          ),
        ],
      );
    }
    if (position == StepPosition.end) {
      return const Center(
        child: Icon(
          CommunityMaterialIcons.map_marker,
          color: Color(0xFFFA163F),
        ),
      );
    }
    return Column(
      children: const [
        Icon(Icons.subdirectory_arrow_left),
        SizedBox(height: 10),
        SizedBox(
          height: 30,
          child: VerticalDivider(
            width: 1,
            thickness: 1,
          ),
        ),
      ],
    );
  }

  EdgeInsetsGeometry getPadding(StepPosition position) {
    if (position == StepPosition.start) {
      return const EdgeInsets.only(top: 1);
    }
    return const EdgeInsets.only(top: 4);
  }

  Widget buildItem({required String text, StepPosition position = StepPosition.start, required ThemeData theme}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 24, child: buildIcon(position)),
        const SizedBox(width: 18),
        Expanded(
          child: Padding(
            padding: getPadding(position),
            child: Text(
              text,
              style: theme.textTheme.overline?.copyWith(
                color: theme.textTheme.subtitle1?.color,
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(address.length, (index) {
        double padBottom = index < address.length - 1 ? 10 : 0;
        StepPosition position = index == 0
            ? StepPosition.start
            : index == address.length - 1
                ? StepPosition.end
                : StepPosition.middle;
        return Padding(
          padding: EdgeInsets.only(bottom: padBottom),
          child: buildItem(text: address[index], position: position, theme: theme),
        );
      }),
    );
  }
}
