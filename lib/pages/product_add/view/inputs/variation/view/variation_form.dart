import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:formz/formz.dart';
import 'package:products_repository/products_repository.dart';

import '../bloc/variation_bloc.dart';
import 'inputs/inputs.dart';
import 'variation_field.dart';

class VariationForm extends StatefulWidget {
  final List<AttributeData> attributes;
  final Widget button;

  const VariationForm({
    Key? key,
    required this.attributes,
    required this.button,
  }) : super(key: key);

  @override
  VariationFormState createState() => VariationFormState();
}

class VariationFormState extends State<VariationForm> {
  bool _showExpend = true;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(25, 8, 25, 25),
      child: Column(
        children: [
          VariationAttribute(attributes: widget.attributes),
          const SizedBox(height: 8),
          InkWell(
            onTap: () => setState(() {
              _showExpend = !_showExpend;
            }),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child: Text(AppLocalizations.of(context)!.translate('common:text_expand'))),
                      Icon(
                        _showExpend ? CommunityMaterialIcons.chevron_down : CommunityMaterialIcons.chevron_right,
                        color: theme.textTheme.caption?.color,
                      ),
                    ],
                  ),
                ),
                const Divider(thickness: 1, height: 1),
              ],
            ),
          ),
          if (_showExpend)
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: VariationField(),
            ),
          const SizedBox(height: 24),
          SizedBox(width: double.infinity, child: widget.button),
        ],
      ),
    );
  }
}

class ButtonUpdate extends StatelessWidget with SnackMixin, LoadingMixin {
  final String? text;
  final ButtonStyle? style;

  const ButtonUpdate({
    Key? key,
    this.text,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    return BlocListener<VariationBloc, VariationState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          showError(context, state.errorMessage ?? translate('message:text_update_variation_fail'));
        }
        if (state.status.isSubmissionSuccess) {
          showSuccess(context, translate('message:text_update_variation_success'));
          Navigator.pop(context, state.toJson());
        }
      },
      child: BlocBuilder<VariationBloc, VariationState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return ElevatedButton(
            key: const Key('variation_form_button'),
            onPressed: () {
              if (!state.status.isSubmissionInProgress) {
                context.read<VariationBloc>().add(const VariationUpdateSubmitted());
              }
            },
            style: style,
            child: state.status.isSubmissionInProgress
                ? buildLoadingElevated()
                : Text(translate('common:text_button_save')),
          );
        },
      ),
    );
  }
}

class ButtonAdd extends StatelessWidget with SnackMixin, LoadingMixin {
  final String? text;
  final ButtonStyle? style;

  const ButtonAdd({
    Key? key,
    this.text,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    return BlocListener<VariationBloc, VariationState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          showError(context, state.errorMessage ?? translate('message:text_add_variation_fail'));
        }
        if (state.status.isSubmissionSuccess) {
          showSuccess(context, translate('message:text_add_variation_success'));
          Navigator.pop(context, state.toJson());
        }
      },
      child: BlocBuilder<VariationBloc, VariationState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return ElevatedButton(
            key: const Key('variation_form_button'),
            onPressed: () {
              if (!state.status.isSubmissionInProgress) {
                context.read<VariationBloc>().add(const VariationAddSubmitted());
              }
            },
            style: style,
            child: state.status.isSubmissionInProgress
                ? buildLoadingElevated()
                : Text(translate('common:text_button_save')),
          );
        },
      ),
    );
  }
}
