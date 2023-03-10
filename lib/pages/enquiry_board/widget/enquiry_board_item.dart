import 'package:enquiry_repository/enquiry_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_store_manager/constants/color_block.dart';
import 'package:flutter_store_manager/themes.dart';

import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

class EnquiryBoardItem extends StatelessWidget with EnquiryBoardMixin {
  final Enquiry? enquiryBoard;
  final GestureTapCallback? onTap;
  final bool? isReply;
  const EnquiryBoardItem({
    Key? key,
    this.enquiryBoard,
    this.onTap,
    this.isReply,
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
      icon: buildImage(isLoading: loading, theme: theme, url: ''),
      name: buildName(name: enquiryBoard?.customerName ?? 'Customer', theme: theme, isLoading: loading),
      enquiry: buildEnquiry(enquiry: enquiryBoard?.enquiry ?? '', theme: theme, isLoading: loading),
      reply: isReply == true ? Container() : buildReplyItem(replyBy: enquiryBoard?.replyBy, loading: loading),
      isReply: isReply,
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
