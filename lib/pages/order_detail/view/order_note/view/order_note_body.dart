/// Flutter library
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';
import 'package:flutter_store_manager/pages/order_detail/view/order_note/cubit/order_note_cubit.dart';
import 'package:order_repository/order_repository.dart';

import 'package:url_launcher/url_launcher.dart';

/// Dependencies
import 'package:flutter_store_manager/types/types.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:flutter_store_manager/themes.dart';

class OrderNoteBody extends StatefulWidget {
  final int orderId;
  const OrderNoteBody({
    Key? key,
    required this.orderId,
  }) : super(key: key);

  @override
  OrderNoteBodyState createState() => OrderNoteBodyState();
}

class OrderNoteBodyState extends State<OrderNoteBody> with SnackMixin, LoadingMixin {
  late OrderNoteCubit cubit;
  final _addNoteController = TextEditingController();
  bool _isExpanded = true;
  @override
  void initState() {
    super.initState();
    cubit = context.read<OrderNoteCubit>();
    cubit.getOrderNotes(id: widget.orderId);
  }

  @override
  void dispose() {
    super.dispose();
    cubit.close();
  }

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    return BlocListener<OrderNoteCubit, OrderNoteState>(
      listenWhen: (previous, current) => previous.addLoadingState != current.addLoadingState,
      listener: (context, state) {
        if (state.addLoadingState is ErrorState) {
          showError(context, AppLocalizations.of(context)!.translate('message:text_add_order_note_fail'));
        }
        if (state.addLoadingState is LoadedState) {
          _addNoteController.clear();
          showSuccess(context, AppLocalizations.of(context)!.translate('message:text_add_order_note_success'));
        }
      },
      child: BlocBuilder<OrderNoteCubit, OrderNoteState>(
        buildWhen: (previous, current) => (previous.orderNotes != current.orderNotes),
        builder: (context, state) {
          ThemeData theme = Theme.of(context);
          List<OrderNote>? orderNotes = state.orderNotes;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Theme(
                data: theme.copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  initiallyExpanded: true,
                  title: LabelInput(
                    title: translate('order:text_order_note'),
                    isLarge: true,
                    padding: const EdgeInsets.only(top: 0.5),
                  ),
                  onExpansionChanged: orderNotes != null
                      ? (value) {
                          setState(() {
                            _isExpanded = value;
                          });
                        }
                      : null,
                  trailing: orderNotes != null
                      ? AnimatedRotation(
                          turns: _isExpanded ? .25 : 0,
                          duration: const Duration(milliseconds: 200),
                          child: const Icon(Icons.chevron_right_rounded),
                        )
                      : const SizedBox(),
                  children: [
                    if (orderNotes != null) _buildItemNote(context, orderNotes),
                  ],
                ),
              ),
              SizedBox(height: !_isExpanded ? 0 : 20),
              LabelInput(
                title: translate('order:text_add_note'),
                isLarge: true,
              ),
              const SizedBox(height: 8),
              _buildAddNoteField(_addNoteController, translate),
              _buildSelect(translate),
              Center(
                child: _buildAddNoteButton(widget.orderId, translate),
              )
            ],
          );
        },
      ),
    );
  }

  Future<void> _launch(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  _buildItemNote(BuildContext context, List<OrderNote> orderNotes) {
    ThemeData theme = Theme.of(context);
    return Column(
      children: List.generate(
        orderNotes.length,
        (index) {
          OrderNote data = orderNotes[index];
          TextStyle defaultStyle = theme.textTheme.bodyText2!;
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: data.customerNote == true ? Colors.transparent : theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: theme.colorScheme.surface),
                ),
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${formatDate(date: data.dateCreated?['date'] ?? DateTime.now().toString(), dateFormat: 'dd/MM/yyyy')} | ',
                              style: theme.textTheme.caption,
                            ),
                            Text(
                              formatDate(
                                  date: data.dateCreated?['date'] ?? DateTime.now().toString(), dateFormat: 'hh:mm a'),
                              style: theme.textTheme.caption,
                            ),
                          ],
                        ),
                        if (data.customerNote != true)
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: theme.dividerColor,
                            ),
                            child: const Icon(
                              CommunityMaterialIcons.lock_outline,
                              size: 15,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Html(
                      data: "<div>${data.content}</div>",
                      onLinkTap: (url, _, __, ___) async {
                        _launch(Uri.parse(url!));
                      },
                      style: {
                        "div": Style.fromTextStyle(defaultStyle),
                        "body": Style(margin: EdgeInsets.zero),
                        "p": Style(margin: EdgeInsets.zero),
                        "a": Style(textDecoration: TextDecoration.none),
                      },
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  _buildAddNoteField(TextEditingController addNoteController, TranslateType translate) {
    return BlocBuilder<OrderNoteCubit, OrderNoteState>(
      builder: (context, state) {
        return InputTextField(
          controller: addNoteController,
          label: translate('order:text_note'),
          maxLines: 5,
          enabled: state.addLoadingState is! LoadingState,
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).cardColor,
          ),
          onChanged: (value) {
            context.read<OrderNoteCubit>().addNoteChanged(value: value);
          },
        );
      },
    );
  }

  _buildSelect(TranslateType translate) {
    Option getValue(String key, List<Option> data) {
      Option select = data.firstWhere((o) => key == o.key);
      return select;
    }

    List<Option> options = [
      Option(key: '0', name: translate('order:text_customer')),
      Option(key: '1', name: translate('order:text_private')),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: BlocBuilder<OrderNoteCubit, OrderNoteState>(
        buildWhen: (previous, current) => (previous.selectedCustomer != current.selectedCustomer),
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabelInput(
                title: translate('order:text_type'),
              ),
              InputDropdown2(
                onChanged: (value) {
                  context.read<OrderNoteCubit>().selectCustomer(value: value.key);
                },
                value: getValue(state.selectedCustomer.toString(), options),
                options: options,
              )
            ],
          );
        },
      ),
    );
  }

  _buildAddNoteButton(
    int orderId,
    TranslateType translate,
  ) {
    return BlocBuilder<OrderNoteCubit, OrderNoteState>(
      builder: (context, state) {
        return SizedBox(
          width: 157,
          child: ElevatedButton(
            onPressed: state.addNoteValue != ''
                ? () {
                    context.read<OrderNoteCubit>().addOrderNotes(id: orderId);
                    FocusScope.of(context).requestFocus(FocusNode());
                  }
                : null,
            child:
                state.addLoadingState is LoadingState ? buildLoadingElevated() : Text(translate('order:text_add_note')),
          ),
        );
      },
    );
  }
}
