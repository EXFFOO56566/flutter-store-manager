import 'package:appcheap_flutter_core/utils/app_localization.dart';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:collection/collection.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/mixins/utility_mixin.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:flutter_store_manager/types/types.dart';

import '../cubit/data.dart';
import '../cubit/delete_account_cubit.dart';

class ReasonStep extends StatefulWidget {
  final VoidCallback nextStep;

  const ReasonStep({
    Key? key,
    required this.nextStep,
  }) : super(key: key);

  @override
  State<ReasonStep> createState() => _ReasonStepState();
}

class _ReasonStepState extends State<ReasonStep> with Utility, AppbarMixin {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;

    List<Option> reasonData = getReasonData(translate);

    return BlocBuilder<DeleteAccountCubit, DeleteAccountState>(
      buildWhen: (previous, current) => previous.reason != current.reason,
      builder: (_, state) {
        if (state.reason?.key != null && state.reason?.key != _controller.text) {
          _controller.text = state.reason!.name;
        }

        return Scaffold(
          appBar: AppBar(
            leading: leading(),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            centerTitle: true,
          ),
          extendBodyBehindAppBar: true,
          body: FixedBottom(
            paddingBottom: const EdgeInsets.all(25),
            bottom: ElevatedButton(
              onPressed: state.reason != null ? widget.nextStep : null,
              child: Text(translate('delete_account:text_reason_button')),
            ),
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NotificationEmptyView.button(
                      icon: FontAwesomeIcons.userTimes,
                      titleWidget: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        constraints: const BoxConstraints(maxWidth: 200),
                        child: Text(
                          translate('delete_account:text_txt'),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      contentWidget: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        constraints: const BoxConstraints(maxWidth: 300),
                        child: Text(
                          translate('delete_account:text_reason_description'),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                      isButton: false,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
                      child: GestureDetector(
                        onTap: () async {
                          String? data = await showModalBottomSheet<String>(
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              MediaQueryData mediaQuery = MediaQuery.of(context);
                              return Container(
                                constraints: BoxConstraints(maxHeight: mediaQuery.size.height / 2),
                                child: ModalOptionSingleView(
                                  options: reasonData,
                                  value: state.reason?.key,
                                  onChanged: (String? text) => Navigator.pop(context, text),
                                ),
                              );
                            },
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                            ),
                          );
                          Option? item = reasonData.firstWhereOrNull((element) => element.key == data);
                          if (item != null && item != state.reason) {
                            _controller.text = item.name;
                            if (mounted) {
                              context.read<DeleteAccountCubit>().changeReason(item);
                            }
                          }
                        },
                        child: TextFormField(
                          controller: _controller,
                          decoration: InputDecoration(
                            enabled: false,
                            labelText: translate('delete_account:text_reason_dropdown_label'),
                            hintText: translate('delete_account:text_reason_dropdown_placeholder'),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: const Icon(FeatherIcons.chevronDown, size: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
