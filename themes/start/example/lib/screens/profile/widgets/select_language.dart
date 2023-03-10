import 'package:community_material_icon/community_material_icon.dart';
import 'package:example/blocs/blocs.dart';
import 'package:example/constants/language.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/ui.dart';

class SelectLanguage extends StatelessWidget {
  const SelectLanguage({Key? key}) : super(key: key);
  void clickLanguage(BuildContext context, String selected, List<Option> languages) async {
    final settingCubit = context.read<SettingCubit>();

    String? value = await showModalBottomSheet<String?>(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        MediaQueryData mediaQuery = MediaQuery.of(context);
        return Container(
          constraints: BoxConstraints(maxHeight: mediaQuery.size.height * 0.6),
          child: ModalOptionSingleFooterView(
            options: languages,
            value: selected,
            onPressButton: (String? text) => Navigator.pop(context, text),
          ),
        );
      },
    );
    if (value != null && value != selected) {
      settingCubit.changeLocale(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    List<Option> languages = supportedLocales.entries
        .map((entry) => Option(key: entry.key, name: entry.value['nativeName'] ?? ''))
        .toList()
        .cast<Option>();

    return BlocBuilder<SettingCubit, SettingState>(
      buildWhen: (previous, current) => previous.locale != current.locale,
      builder: (_, state) {
        Option? languageSelect = languages.firstWhereOrNull((e) => e.key == state.locale);
        return TileIconLine(
          icon: CommunityMaterialIcons.translate,
          title: 'Languages',
          isChevron: true,
          trailing: Text(
            languageSelect?.name ?? '',
            style: theme.textTheme.overline?.copyWith(color: theme.textTheme.caption?.color),
          ),
          onTap: () => clickLanguage(context, state.locale, languages),
        );
      },
    );
  }
}
