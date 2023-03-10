// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:feather_icons/feather_icons.dart';

// View
import 'package:flutter_store_manager/mixins/utility_mixin.dart';

//Themes
import 'package:flutter_store_manager/themes.dart';

// Constants
import 'package:flutter_store_manager/constants/color_block.dart';

class ItemLocation extends StatelessWidget with Utility {
  final bool primaryIcon;
  final String title;
  final String subTitle;
  final String search;
  final EdgeInsetsGeometry padding;
  final bool loading;
  final bool isDivider;
  final GestureTapCallback? onTap;

  ItemLocation({
    Key? key,
    this.primaryIcon = false,
    this.title = '',
    this.subTitle = '',
    this.search = '',
    this.padding = const EdgeInsets.symmetric(horizontal: 10),
    this.loading = false,
    this.isDivider = true,
    this.onTap,
  }) : super(key: key);

  List getCutSearchString() {
    List data = [];
    String value = title.toLowerCase().normalize;

    String searchTrim =
        search.trim().split(' ').where((String str) => str.isNotEmpty).toList().join(' ').toLowerCase().normalize;

    int visitContains = value.indexOf(searchTrim);
    if (visitContains < 0) {
      data.add({
        'title': title,
        'isSearch': false,
      });
    } else {
      if (visitContains > 0) {
        data.add({
          'title': title.substring(0, visitContains),
          'isSearch': false,
        });
      }
      int endVisitContains = visitContains + searchTrim.length;
      data.add({
        'title': title.substring(visitContains, endVisitContains),
        'isSearch': true,
      });
      if (endVisitContains < value.length) {
        data.add({
          'title': title.substring(endVisitContains),
          'isSearch': false,
        });
      }
    }
    return data;
  }

  Widget buildTitle(ThemeData theme) {
    if (loading) {
      return const AnimatedShimmer(
        height: 16,
        width: 120,
      );
    }

    List dataTitle = getCutSearchString();

    return RichText(
      maxLines: 1,
      text: TextSpan(
        style: theme.textTheme.subtitle2,
        children: List.generate(
          dataTitle.length,
          (index) {
            dynamic item = dataTitle[index];
            String title = get(item, ['title'], '');
            bool isSearch = get(item, ['isSearch'], false);
            return TextSpan(
              text: title,
              style: isSearch ? const TextStyle(color: ColorBlock.red) : null,
            );
          },
        ),
      ),
    );
  }

  Widget buildSubtitle(ThemeData theme) {
    if (loading) {
      return const AnimatedShimmer(
        height: 16,
        width: 200,
      );
    }

    return Text(
      subTitle,
      style: theme.textTheme.caption,
      maxLines: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return InkWell(
      onTap: !loading ? onTap : null,
      child: Column(
        children: [
          Padding(
            padding: padding,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Icon(
                    FeatherIcons.mapPin,
                    size: 16,
                    color: primaryIcon ? theme.primaryColor : theme.textTheme.caption!.color,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildTitle(theme),
                      buildSubtitle(theme),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isDivider) const Divider(height: 1, thickness: 1),
        ],
      ),
    );
  }
}
