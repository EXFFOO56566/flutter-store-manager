import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/constants/languages.dart';
import 'package:flutter_store_manager/settings/settings.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:flutter_store_manager/themes.dart';

class ProfileLanguage extends StatefulWidget {
  const ProfileLanguage({Key? key}) : super(key: key);

  @override
  State<ProfileLanguage> createState() => _ProfileLanguageState();
}

class _ProfileLanguageState extends State<ProfileLanguage> {
  Future<void> _selectLanguage(BuildContext context, String locate) async {
    String? value = await showModalBottomSheet<String?>(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        MediaQueryData mediaQuery = MediaQuery.of(context);
        return Container(
          constraints: BoxConstraints(maxHeight: mediaQuery.size.height * 0.6),
          child: ModalOptionApply(
            options: supportedLocales.entries
                .map((entry) => Option(key: entry.key, name: entry.value['nativeName'] ?? ''))
                .toList(),
            value: locate,
            onChanged: (String? text) => Navigator.pop(context, text),
            textButton: AppLocalizations.of(context)!.translate('common:text_apply'),
          ),
        );
      },
    );
    if (value != null && value != locate) {
      if (mounted) context.read<SettingsCubit>().changeLanguage(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocBuilder<SettingsCubit, Setting>(
      builder: (context, state) {
        return TileIconLine(
          icon: CommunityMaterialIcons.translate,
          title: AppLocalizations.of(context)!.translate('account:text_language'),
          isChevron: true,
          trailing: Text(
            supportedLocales[state.locate]?['nativeName'] ?? '',
            style: theme.textTheme.overline?.copyWith(color: theme.textTheme.caption?.color),
          ),
          onTap: () => _selectLanguage(context, state.locate),
        );
      },
    );
  }
}
