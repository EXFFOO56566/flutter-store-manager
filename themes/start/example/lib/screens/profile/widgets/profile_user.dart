import 'package:community_material_icon/community_material_icon.dart';
import 'package:example/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/ui.dart';

class ProfileUser extends StatelessWidget {
  const ProfileUser({Key? key}) : super(key: key);

  void onEditAccount() {}

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return ProfileHeading(
          avatar: GestureDetector(
            onTap: onEditAccount,
            child: Container(
              width: 80,
              height: 80,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: theme.cardColor),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(38),
                child: CacheImageView(
                  image: state.user.avatar ?? '',
                  width: 76,
                  height: 76,
                ),
              ),
            ),
          ),
          name: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: onEditAccount,
                child: Text(state.user.fullName ?? '', style: theme.textTheme.subtitle1),
              ),
              Text('View Profile', style: theme.textTheme.caption),
            ],
          ),
          logoutIcon: InkResponse(
            onTap: () {
              context.read<AuthCubit>().logoutAuth();
              context.read<ReportCubit>().initData();
            },
            child: Icon(
              CommunityMaterialIcons.exit_to_app,
              size: 20,
              color: theme.textTheme.caption?.color,
            ),
          ),
        );
      },
    );
  }
}
