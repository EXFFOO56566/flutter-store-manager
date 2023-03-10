import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

import '../../bloc/variation_bloc.dart';

class VariationVirtual extends StatelessWidget {
  const VariationVirtual({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocBuilder<VariationBloc, VariationState>(
      buildWhen: (previous, current) => previous.virtual != current.virtual,
      builder: (_, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(AppLocalizations.of(context)!.translate('product:text_virtual'),
                  style: theme.textTheme.bodyText2),
              contentPadding: EdgeInsets.zero,
              leading: CupertinoSwitch(
                value: state.virtual.value,
                onChanged: (value) => context.read<VariationBloc>().add(VirtualChanged(value)),
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
