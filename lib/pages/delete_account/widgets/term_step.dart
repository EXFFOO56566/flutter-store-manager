import 'package:appcheap_flutter_core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_manager/mixins/utility_mixin.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:flutter_store_manager/types/types.dart';

import '../cubit/data.dart';

class TermStep extends StatelessWidget with AppbarMixin, Utility {
  final VoidCallback nextStep;
  final VoidCallback backStep;

  const TermStep({
    Key? key,
    required this.nextStep,
    required this.backStep,
  }) : super(key: key);

  Widget buildItemView({
    required IconData icon,
    required String name,
    required ThemeData theme,
    required TranslateType translate,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: theme.colorScheme.surface, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Icon(
            icon,
            color: theme.primaryColor,
            size: 32,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(translate(name)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;

    return Scaffold(
      appBar: AppBar(
        leading: leading(onPressed: backStep),
        title: Text(translate('delete_account:text_txt')),
        centerTitle: true,
        shadowColor: Colors.transparent,
      ),
      body: FixedBottom(
        paddingBottom: const EdgeInsets.all(25),
        bottom: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  foregroundColor: theme.textTheme.subtitle1?.color,
                  backgroundColor: theme.colorScheme.surface,
                ),
                child: Text(translate('delete_account:text_term_cancel')),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: ElevatedButton(
                onPressed: nextStep,
                child: Text(translate('delete_account:text_term_next')),
              ),
            ),
          ],
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(25, 8, 25, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(translate('delete_account:text_term_title'), style: theme.textTheme.bodyText2),
              Text(translate('delete_account:text_term_subtitle'),
                  style: theme.textTheme.bodyText2?.copyWith(color: theme.errorColor)),
              const SizedBox(height: 16),
              ...List.generate(termData.length, (index) {
                Map<String, dynamic> item = termData[index];

                IconData icon = get(item, ['icon']);
                String name = get(item, ['label_name']);

                double padBottom = index < termData.length - 1 ? 16 : 0;

                return Padding(
                  padding: EdgeInsets.only(bottom: padBottom),
                  child: buildItemView(
                    icon: icon,
                    name: name,
                    theme: theme,
                    translate: translate,
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
