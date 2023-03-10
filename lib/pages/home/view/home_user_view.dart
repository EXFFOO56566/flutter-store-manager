// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter_bloc/flutter_bloc.dart';

// Bloc
import 'package:flutter_store_manager/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_store_manager/tabs/cubit/tabs_cubit.dart';

// Themes
import 'package:flutter_store_manager/themes.dart';

class HomeUserView extends StatelessWidget {
  const HomeUserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return HomeUser(
          title: AppLocalizations.of(context)!.translate('home:text_user', {'name': state.user.displayName.unescape}),
          time: formatDate(date: DateTime.now().toString(), dateFormat: 'MMM, dd, yyyy'),
          avatar: GestureDetector(
            onTap: () => context.read<TabsCubit>().onItemTapped(4),
            child: _AvatarUser(
              url: state.user.avatar,
            ),
          ),
        );
      },
    );
  }
}

class _AvatarUser extends StatelessWidget {
  final String? url;
  const _AvatarUser({
    Key? key,
    this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: CacheImageView(
            image: url ?? '',
            width: 50,
            height: 50,
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
