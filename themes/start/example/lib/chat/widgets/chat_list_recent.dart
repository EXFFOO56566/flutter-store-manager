import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class ChatListRecent extends StatelessWidget with ChatMixin {
  const ChatListRecent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 0, 25, 20),
          child: Text('Recent Chat', style: theme.textTheme.subtitle2),
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(10, (index) {
              double padEnd = index < 9 ? 20 : 0;
              return Padding(
                padding: EdgeInsetsDirectional.only(end: padEnd),
                child: buildImage(
                  url:
                      'https://static.vecteezy.com/packs/media/components/global/search-explore-nav/img/vectors/term-bg-1-666de2d941529c25aa511dc18d727160.jpg',
                  theme: theme,
                  colorDot: const Color(0xFFFDC309),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
