import 'package:example/blocs/blocs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/ui.dart';

class SwitchDarkMode extends StatelessWidget {
  const SwitchDarkMode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingCubit, SettingState>(
      buildWhen: (previous, current) => previous.brightness != current.brightness,
      builder: (_, state) {
        return TileIconLine(
          icon: Icons.opacity,
          title: 'Dark Mode',
          trailing: CupertinoSwitch(
            value: state.brightness == Brightness.dark,
            onChanged: (_) => context.read<SettingCubit>().toggleBrightness(),
          ),
        );
      },
    );
  }
}
