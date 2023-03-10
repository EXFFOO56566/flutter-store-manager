import 'package:appcheap_flutter_core/di/di.dart';
import 'package:appcheap_flutter_core/utils/utils.dart';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';
import 'package:flutter_store_manager/mixins/utility_mixin.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:flutter_store_manager/types/types.dart';

import '../cubit/delete_account_cubit.dart';

class AgreeStep extends StatelessWidget with Utility, AppbarMixin, LoadingMixin, SnackMixin {
  final VoidCallback nextStep;
  final VoidCallback backStep;

  const AgreeStep({
    Key? key,
    required this.nextStep,
    required this.backStep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;

    return BlocListener<DeleteAccountCubit, DeleteAccountState>(
      listenWhen: (previous, current) => previous.statusSendOtp != current.statusSendOtp,
      listener: (context, state) {
        if (state.statusSendOtp is ErrorState) {
          dynamic error = state.statusSendOtp.props[0];
          showError(
            context,
            error is RequestError ? error.message : 'Fail',
          );
        }
        if (state.statusSendOtp is LoadedState) {
          nextStep();
        }
      },
      child: BlocBuilder<DeleteAccountCubit, DeleteAccountState>(
        buildWhen: (previous, current) =>
            previous.statusSendOtp != current.statusSendOtp || previous.isAgree != current.isAgree,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: leading(onPressed: backStep),
              shadowColor: Colors.transparent,
            ),
            extendBodyBehindAppBar: true,
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
                      child: Text(translate('delete_account:text_agree_cancel')),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: state.isAgree
                          ? () {
                              if (state.statusSendOtp is! LoadingState) {
                                context.read<DeleteAccountCubit>().sendOtp();
                              }
                            }
                          : null,
                      child: state.statusSendOtp is LoadingState
                          ? buildLoadingElevated()
                          : Text(translate('delete_account:text_agree_send')),
                    ),
                  ),
                ],
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      NotificationEmptyView.button(
                        icon: FontAwesomeIcons.userTimes,
                        titleWidget: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Text(
                            translate('delete_account:text_agree_title'),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                        contentWidget: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Text(
                            translate('delete_account:text_agree_subtitle'),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                        isButton: false,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkResponse(
                            onTap: () => context.read<DeleteAccountCubit>().changeIsAgree(!state.isAgree),
                            child: Icon(
                              state.isAgree
                                  ? CommunityMaterialIcons.checkbox_marked
                                  : CommunityMaterialIcons.checkbox_blank_outline,
                              color: state.isAgree ? theme.primaryColor : theme.textTheme.caption?.color,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Flexible(
                            child: Text(
                              translate('delete_account:text_agree_checkbox'),
                              style: theme.textTheme.caption?.copyWith(
                                color: state.isAgree ? theme.textTheme.subtitle1?.color : null,
                                fontWeight: state.isAgree ? theme.textTheme.subtitle1?.fontWeight : null,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
