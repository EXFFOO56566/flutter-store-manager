import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../../screens.dart';

class ProfileUser extends StatelessWidget {
  const ProfileUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ProfileHeading(
      avatar: GestureDetector(
        onTap: () => Navigator.pushNamed(context, SettingPersonScreen.routeName),
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: theme.cardColor),
            shape: BoxShape.circle,
            image: const DecorationImage(
              image: NetworkImage(
                  'https://static.vecteezy.com/packs/media/components/global/search-explore-nav/img/vectors/term-bg-1-666de2d941529c25aa511dc18d727160.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      name: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, SettingPersonScreen.routeName),
            child: Text('Gladys Fisher', style: theme.textTheme.subtitle1),
          ),
          Text('View Profile', style: theme.textTheme.caption),
        ],
      ),
      logoutIcon: InkResponse(
        onTap: () => Navigator.pushNamed(context, LoginScreen.routeName),
        child: Icon(
          CommunityMaterialIcons.exit_to_app,
          size: 20,
          color: theme.textTheme.caption?.color,
        ),
      ),
    );
  }
}
