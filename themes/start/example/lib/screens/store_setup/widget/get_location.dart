import 'package:example/screens/store_setup/bloc/store_setting_bloc.dart';
import 'package:example/screens/store_setup/model/user_location.dart';
import 'package:example/screens/store_setup/widget/modal_find_on_map.dart';
import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/models/option.dart';

class GetLocationField extends StatelessWidget {
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

  Widget buildHintText(ThemeData theme) {
    return Text(
      hintText ?? '',
      style: theme.textTheme.caption,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget buildIcon(ThemeData theme) {
    Color? color = isOutline == false ? null : theme.textTheme.caption?.color;
    double size = isSmall ? 22 : 24;
    return Icon(CommunityMaterialIcons.chevron_down, size: size, color: color);
  }

  Widget buildView(
    BuildContext context, {
    required ThemeData theme,
    required Widget child,
    Option? option,
  }) {
    Color? backgroundColor = isOutline == false ? theme.colorScheme.surface : null;
    Border? border = isOutline == false ? null : Border.all(color: theme.dividerColor);

    double size = isSmall ? 30 : 51;
    double radius = isSmall ? 8 : 10;
    EdgeInsetsGeometry padding = isSmall
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
          final storeSettingBloc = context.read<StoreSettingBloc>();

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
                    return StoreSettingBloc(token: '');
                  },
                  child: ModalFindOnMap(
                    initUserLocation: storeSettingState.userLocationFromId ??
                        UserLocation(lat: 0, lng: 0, address: 'Apple Campus, CA, US'),
                    isExpand: true,
                    isSearch: true,
                    hintTextSearch: "Search",
                  ),
                ),
              );
            },
          );
          if (value != null) {
            storeSettingBloc.add(UpdateUserLocationEvent(userLocation: value));
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
