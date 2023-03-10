import 'package:example/constants/color_block.dart';
import 'package:example/screens/enquiry_board/models/enquiry_board.dart';
import 'package:flutter/material.dart';
import 'package:ui/items/enquiry_board_item_ui.dart';
import 'package:ui/mixins/mixins.dart';

import '../utils/date_format.dart';

class EnquiryBoardItem extends StatelessWidget with EnquiryBoardMixin {
  final EnquiryBoard? enquiryBoard;
  final GestureTapCallback? onTap;
  const EnquiryBoardItem({
    Key? key,
    this.enquiryBoard,
    this.onTap,
  }) : super(key: key);

  Widget buildReplyItem({String? replyBy, bool loading = true}) {
    bool checkReply = !(replyBy == null || replyBy == '0');
    String textReply = !checkReply ? 'Un-replied' : 'Replied';
    Color color = !checkReply ? ColorBlock.redError : ColorBlock.green;

    return buildReply(reply: textReply, color: color, isLoading: loading);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    bool loading = enquiryBoard?.id == null;
    return EnquiryBoardItemUi(
      onTap: !loading ? onTap : null,
      icon: buildImage(isLoading: loading, theme: theme),
      name: buildName(name: enquiryBoard?.customerName ?? 'Customer', theme: theme, isLoading: loading),
      enquiry: buildEnquiry(enquiry: enquiryBoard?.enquiry ?? '', theme: theme, isLoading: loading),
      reply: buildReplyItem(replyBy: enquiryBoard?.replyBy, loading: loading),
      dateTime: buildDateTimeEmail(
        date: formatDate(date: enquiryBoard?.date ?? DateTime.now().toString(), dateFormat: 'dd/MM/yyyy'),
        time: formatDate(date: enquiryBoard?.date ?? DateTime.now().toString(), dateFormat: 'hh:mm a'),
        email: enquiryBoard?.customerEmail,
        theme: theme,
        isLoading: loading,
      ),
      padding: const EdgeInsets.symmetric(vertical: 18),
    );
  }
}
