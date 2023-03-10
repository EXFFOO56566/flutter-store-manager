import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/pages/media/media.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

class MediaLibraryPageBottom extends StatelessWidget {
  final ValueChanged<dynamic> onChanged;
  const MediaLibraryPageBottom({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;

    return BlocBuilder<MediaCubit, MediaState>(
      builder: (context, state) {
        if (state.mediaSelected.isEmpty) {
          return Container(height: 0);
        }
        ButtonStyle buttonStyle = ElevatedButton.styleFrom(
          foregroundColor: theme.textTheme.subtitle1?.color,
          backgroundColor: theme.colorScheme.surface,
          textStyle: theme.textTheme.overline,
          minimumSize: const Size(0, 29),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        );

        if (state.isSelectMulti) {
          return MediaListBottom(
            title: Text(translate('media:text_count_select', {'count': '${state.mediaSelected.length}'}),
                style: theme.textTheme.bodyText2),
            action: ElevatedButton(
              onPressed: () => onChanged(state.mediaSelected),
              style: buttonStyle,
              child: Text(translate('common:text_done')),
            ),
          );
        }
        return MediaListBottom(
          title: Text(translate('media:text_select'), style: theme.textTheme.bodyText2),
          action: ElevatedButton(
            onPressed: () => onChanged(state.mediaSelected),
            style: buttonStyle,
            child: Text(translate('common:text_done')),
          ),
        );
      },
    );
  }
}
