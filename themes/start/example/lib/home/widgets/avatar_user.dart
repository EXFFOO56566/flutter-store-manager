import 'package:flutter/material.dart';

class AvatarUser extends StatelessWidget {
  const AvatarUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(
                  'https://static.vecteezy.com/packs/media/components/global/search-explore-nav/img/vectors/term-bg-1-666de2d941529c25aa511dc18d727160.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        PositionedDirectional(
          start: -5,
          top: 3.5,
          child: Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              color: theme.colorScheme.error,
              shape: BoxShape.circle,
              border: Border.all(width: 2, color: theme.cardColor),
            ),
          ),
        ),
      ],
    );
  }
}
