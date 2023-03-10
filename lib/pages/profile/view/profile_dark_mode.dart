import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/settings/settings.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:flutter_store_manager/themes.dart';

class ProfileDarkMode extends StatelessWidget {
  const ProfileDarkMode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, Setting>(
      builder: (context, state) {
        return TileIconLine(
          icon: Icons.opacity,
          title: AppLocalizations.of(context)!.translate('account:text_dark_mode'),
          trailing: CupertinoSwitch(
            value: state.brightness == Brightness.dark,
            onChanged: (_) => context.read<SettingsCubit>().toggleBrightness(),
          ),
        );
      },
    );
  }
}
