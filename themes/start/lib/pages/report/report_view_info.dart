import 'package:flutter/material.dart';

class ReportViewInfo extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const ReportViewInfo({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  Widget buildInfo() {
    int length = children.length;
    int col = 2;
    int row = (length / col).ceil();

    return Column(
      children: List.generate(row, (index) {
        double padBottom = index < row - 1 ? 12 : 0;
        return Padding(
          padding: EdgeInsets.only(bottom: padBottom),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < col; i++) ...[
                Expanded(child: buildItem(index, i, col)),
                if (i < col - 1) const SizedBox(width: 12),
              ]
            ],
          ),
        );
      }),
    );
  }

  Widget buildItem(int x, int y, int col) {
    int visit = x * col + y;
    if (visit >= children.length) {
      return Container();
    }
    return children[visit];
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: theme.textTheme.subtitle2),
        const SizedBox(height: 18),
        buildInfo(),
      ],
    );
  }
}
