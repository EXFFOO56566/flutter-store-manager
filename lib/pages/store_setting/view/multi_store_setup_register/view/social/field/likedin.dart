// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:community_material_icon/community_material_icon.dart';

// Bloc
import '../../../../../bloc/store_setting_bloc.dart';

// Themes
import 'package:flutter_store_manager/themes.dart';

class LikeinLinkWidget extends StatelessWidget {
  LikeinLinkWidget({Key? key}) : super(key: key);
  final _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocBuilder<StoreSettingBloc, StoreSettingState>(
      buildWhen: (previous, current) => previous.likedinLink != current.likedinLink,
      builder: (context, state) {
        return InputTextField(
          focusNode: _focusNode,
          label: AppLocalizations.of(context)!.translate('inputs:text_linkedin'),
          controller: TextEditingController(text: state.likedinLink ?? ""),
          decoration: InputDecoration(
            prefixIcon: Icon(
              CommunityMaterialIcons.linkedin,
              size: 20,
              color: theme.textTheme.overline?.color,
            ),
          ),
          onChanged: (youtubeLink) {
            _focusNode.addListener(() {
              if (!_focusNode.hasFocus) {
                context.read<StoreSettingBloc>().add(LikedinLinkChanged(youtubeLink));
              }
            });
          },
        );
      },
    );
  }
}
