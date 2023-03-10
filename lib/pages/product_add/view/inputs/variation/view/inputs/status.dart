import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

import '../../bloc/variation_bloc.dart';

class VariationStatus extends StatelessWidget {
  const VariationStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocBuilder<VariationBloc, VariationState>(
      buildWhen: (previous, current) => previous.statusType != current.statusType,
      builder: (_, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title:
                  Text(AppLocalizations.of(context)!.translate('common:text_enable'), style: theme.textTheme.bodyText2),
              contentPadding: EdgeInsets.zero,
              leading: CupertinoSwitch(
                value: state.statusType.value == 'publish',
                onChanged: (bool value) {
                  String type = !value ? 'private' : 'publish';
                  context.read<VariationBloc>().add(StatusTypeChanged(type));
                },
              ),
              horizontalTitleGap: 11,
              minLeadingWidth: 0,
            ),
            const Divider(height: 1, thickness: 1),
          ],
        );
      },
    );
  }
}
