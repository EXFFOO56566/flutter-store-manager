// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Repository packages
import 'package:store_setting_repository/store_setting_repository.dart';
import 'package:google_place_repository/google_place_repository.dart';

// Bloc
import 'package:flutter_store_manager/authentication/authentication.dart';
import '../../../../bloc/store_setting_bloc.dart';

// View
import 'modal_find_on_map.dart';

// Constants
import 'package:flutter_store_manager/constants/constants.dart';
import 'package:flutter_store_manager/constants/credentials.dart';

//Models
import 'package:flutter_store_manager/themes.dart';

class GetLocationField extends StatefulWidget {
  final String? hintText;
  final String? value;
  final double ratioHeightModal;
  final bool isOutline;
  final bool isSmall;
  final StoreSettingState storeSettingState;

  const GetLocationField(
      {Key? key,
      this.hintText,
      this.value,
      this.ratioHeightModal = 0.6,
      this.isOutline = true,
      this.isSmall = false,
      required this.storeSettingState})
      : assert(ratioHeightModal >= 0 && ratioHeightModal <= 1),
        super(key: key);

  @override
  State<GetLocationField> createState() => _GetLocationFieldState();
}

class _GetLocationFieldState extends State<GetLocationField> {
  Widget buildHintText(ThemeData theme) {
    return Text(
      widget.hintText ?? '',
      style: theme.textTheme.caption,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget buildIcon(ThemeData theme) {
    Color? color = widget.isOutline == false ? null : theme.textTheme.caption?.color;
    double size = widget.isSmall ? 22 : 24;
    return Icon(CommunityMaterialIcons.chevron_down, size: size, color: color);
  }

  Widget buildView(
    BuildContext context, {
    required ThemeData theme,
    required Widget child,
    Option? option,
  }) {
    Color? backgroundColor = widget.isOutline == false ? theme.colorScheme.surface : null;
    Border? border = widget.isOutline == false ? null : Border.all(color: theme.dividerColor);

    double size = widget.isSmall ? 30 : 51;
    double radius = widget.isSmall ? 8 : 10;
    EdgeInsetsGeometry padding = widget.isSmall
        ? const EdgeInsetsDirectional.only(start: 14, end: 10)
        : const EdgeInsetsDirectional.only(start: 16, end: 12);
    return InkWell(
      borderRadius: BorderRadius.circular(radius),
      onTap: () async {},
      child: Container(
        height: size,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: border,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return buildView(
      context,
      theme: theme,
      child: InkResponse(
        onTap: () async {
          UserLocation? value = await showModalBottomSheet<UserLocation?>(
            context: context,
            isScrollControlled: true,
            enableDrag: false,
            builder: (BuildContext context) {
              MediaQueryData mediaQuery = MediaQuery.of(context);
              double height = mediaQuery.size.height - mediaQuery.viewInsets.top - mediaQuery.viewInsets.bottom;
              return Container(
                constraints: BoxConstraints(maxHeight: height - (mediaQuery.size.height * 0.2)),
                margin: mediaQuery.viewInsets,
                child: BlocProvider(
                  create: (context) {
                    return StoreSettingBloc(
                      storeSettingRepository: StoreSettingRepository(context.read<HttpClient>()),
                      googlePlaceRepository: GooglePlaceRepository(googleMapApiKey: googleMapApiKey)..init(),
                      token: context.read<AuthenticationBloc>().state.token,
                    );
                  },
                  child: ModalFindOnMap(
                    initUserLocation: widget.storeSettingState.userLocationFromId ??
                        UserLocation(lat: initLat, lng: initLng, address: 'Apple Campus, CA, US'),
                    isExpand: true,
                    isSearch: true,
                    hintTextSearch: AppLocalizations.of(context)!.translate('common:text_search'),
                  ),
                ),
              );
            },
          );
          if (value != null) {
            if (mounted) context.read<StoreSettingBloc>().add(UpdateUserLocationEvent(userLocation: value));
          }
        },
        child: Row(
          children: [
            Expanded(child: buildHintText(theme)),
            const SizedBox(width: 12),
            buildIcon(theme),
          ],
        ),
      ),
    );
  }
}
