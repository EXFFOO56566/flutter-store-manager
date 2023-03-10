// Flutter code
import 'package:flutter/material.dart';

// Dependencies
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/authentication/authentication.dart';
import 'package:flutter_store_manager/pages/orders/bloc/order_cubit.dart';
import 'package:flutter_store_manager/pages/products/bloc/product_cubit.dart';
import 'package:flutter_store_manager/pages/update_personal/view/update_personal_screen.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter_store_manager/stores/global/bloc/global_bloc.dart';

// Themes
import 'package:flutter_store_manager/themes.dart';
import 'package:flutter_store_manager/types/types.dart';

class ProfileUser extends StatelessWidget {
  const ProfileUser({Key? key}) : super(key: key);

  void goUpdateProfile(BuildContext context) {
    Navigator.pushNamed(context, UpdatePersonalScreen.routeName);
  }

  void _dialogLogout(
      BuildContext context, TranslateType translate, AuthenticationBloc authBloc, GlobalBloc globalBloc) async {
    String? value = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(translate('account:text_logout')),
          content: Text(translate('account:text_logout_description')),
          actions: <Widget>[
            TextButton(onPressed: () => Navigator.pop(context), child: Text(translate('common:text_cancel'))),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: Text(translate('common:text_ok')),
            ),
          ],
        );
      },
    );
    if (value == 'OK') {
      authBloc.add(AuthenticationLogoutRequested());
      globalBloc.add(const GlobalStoreChanged('products', ProductState(products: [])));
      globalBloc.add(const GlobalStoreChanged('orders', OrderState(orders: [])));
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return ProfileHeading(
          avatar: GestureDetector(
            onTap: () => goUpdateProfile(context),
            child: Container(
              width: 80,
              height: 80,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: theme.cardColor,
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(38),
                child: CacheImageView(
                  image: state.user.avatar,
                  width: 76,
                  height: 76,
                ),
              ),
            ),
          ),
          name: GestureDetector(
            onTap: () => goUpdateProfile(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(state.user.displayName.unescape, style: theme.textTheme.subtitle1),
                Text(translate('account:text_view_profile'), style: theme.textTheme.caption),
              ],
            ),
          ),
          logoutIcon: InkResponse(
            onTap: () => _dialogLogout(
              context,
              translate,
              context.read<AuthenticationBloc>(),
              context.read<GlobalBloc>(),
            ),
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
