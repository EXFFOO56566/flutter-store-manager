import 'package:enquiry_repository/enquiry_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';
import 'package:flutter_store_manager/pages/enquiry_board/widget/enquiry_board_item.dart';
import 'package:flutter_store_manager/pages/enquiry_reply/cubit/enquiry_reply_cubit.dart';
import 'package:flutter_store_manager/themes.dart';

import '../../../types/types.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'reply_button.dart';
import 'reply_item.dart';

class EnquiryReplyBody extends StatefulWidget {
  final String id;
  const EnquiryReplyBody({Key? key, required this.id}) : super(key: key);
  @override
  EnquiryReplyBodyState createState() => EnquiryReplyBodyState();
}

class EnquiryReplyBodyState extends State<EnquiryReplyBody> with AppbarMixin, LoadingMixin {
  final ScrollController _controller = ScrollController();
  late EnquiryReplyCubit cubit;
  bool enableKey = false;
  final double _height = 119.61;

  void _animateToIndex(int index) {
    _controller.animateTo(
      index * _height,
      duration: const Duration(microseconds: 100),
      curve: Curves.linear,
    );
  }

  @override
  void initState() {
    cubit = context.read<EnquiryReplyCubit>();
    cubit.getEnquiryDetail(id: ConvertData.stringToInt(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;

    ThemeData theme = Theme.of(context);
    return BlocBuilder<EnquiryReplyCubit, EnquiryReplyState>(
      builder: (context, state) {
        if (state.replyState is LoadingState) {
          _animateToIndex(state.data!.data!.length);
        }
        String title = AppLocalizations.of(context)!.translate('enquiry:text_replies');
        if (state.actionState is LoadingState) {
          return Scaffold(
            appBar: baseStyleAppBar(title: title),
            body: Center(child: buildLoading()),
          );
        }
        if (state.data?.id == null) {
          return Scaffold(
            appBar: baseStyleAppBar(title: title),
            body: Center(
              child: Text(translate('common:text_no_data')),
            ),
          );
        }
        EnquiryReplyData data = state.data!;
        Enquiry item = Enquiry.fromJson(data.toJson());

        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    controller: _controller,
                    slivers: [
                      baseSliverAppBar(title: title),
                      buildInfo(item: item, theme: theme),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
                          child: _body(state, translate),
                        ),
                      ),
                    ],
                  ),
                ),
                const ReplyButton(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _body(EnquiryReplyState state, TranslateType translate) {
    EnquiryReplyData data = state.data!;
    ThemeData theme = Theme.of(context);
    String id = StringGenerate.uuid();
    List<DataReply> replies = data.data ?? [];
    if (state.reply != '') {
      replies.add(DataReply(
        reply: state.reply,
        date: "${DateTime.now()}",
        replyImage: replies.isEmpty ? "" : replies[0].replyImage,
        replyName: replies.isEmpty ? "" : replies[0].replyName,
        id: id,
      ));
    }
    if (state.progress == 100) {
      replies.removeLast();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          translate('enquiry:text_replies_count', {'count': '${replies.length}'}),
          style: theme.textTheme.subtitle1,
        ),
        const SizedBox(height: 32),
        ...List.generate(replies.length, (index) {
          return ReplyItem(
            item: replies[index],
            id: id,
          );
        }),
      ],
    );
  }

  SliverAppBar buildInfo({required Enquiry item, required ThemeData theme}) {
    String text = item.enquiry ?? '';

    int count = text.split('<br').length;

    double collapsedHeight = count > 1 ? 65 + (count - 1) * 24 : 65;

    return SliverAppBar(
      automaticallyImplyLeading: false,
      collapsedHeight: collapsedHeight,
      backgroundColor: theme.scaffoldBackgroundColor,
      flexibleSpace: Container(
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: EnquiryBoardItem(
          enquiryBoard: item,
          isReply: true,
        ),
      ),
      floating: true,
    );
  }
}
