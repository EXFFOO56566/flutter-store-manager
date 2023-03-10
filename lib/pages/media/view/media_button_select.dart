import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/pages/media/media.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

class MediaButtonSelect extends StatelessWidget {
  final VoidCallback? onPressed;

  const MediaButtonSelect({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;

    return BlocBuilder<MediaCubit, MediaState>(
      builder: (context, state) {
        if (!state.isSwitchSelect) {
          return Container();
        }
        ButtonStyle buttonStyle = state.isSelect
            ? ElevatedButton.styleFrom(
                textStyle: theme.textTheme.overline,
                minimumSize: const Size(0, 29),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              )
            : ElevatedButton.styleFrom(
                foregroundColor: theme.textTheme.subtitle1?.color,
                backgroundColor: theme.colorScheme.surface,
                textStyle: theme.textTheme.overline,
                minimumSize: const Size(0, 29),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              );

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.read<MediaCubit>().changeIsSelect(isSelect: !state.isSelect),
              style: buttonStyle,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(CommunityMaterialIcons.check_all, size: 16),
                  const SizedBox(width: 8),
                  Text(translate('common:text_select')),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
