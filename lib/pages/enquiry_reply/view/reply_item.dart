import 'package:enquiry_repository/enquiry_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

class ReplyItem extends StatelessWidget with LoadingMixin {
  final DataReply item;
  final String? id;

  const ReplyItem({
    Key? key,
    required this.item,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: CacheImageView(
                image: item.replyImage ?? '',
                width: 60,
                height: 60,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.replyName ?? '', style: theme.textTheme.subtitle2),
                  const SizedBox(height: 6),
                  Text(
                    formatDate(date: item.date ?? DateTime.now().toString(), dateFormat: 'dd/MM/yyyy hh:mm a'),
                    style: theme.textTheme.overline,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Html(
                        data: '<div>${item.reply ?? ''}</div>'.replaceAll('\\n', '<br>'),
                        shrinkWrap: true,
                        style: {
                          "div": Style.fromTextStyle(theme.textTheme.caption ?? const TextStyle()),
                          'p': Style(
                            margin: EdgeInsets.zero,
                          ),
                          'body': Style(margin: EdgeInsets.zero),
                        },
                      ),
                      id == item.id ? buildLoading(radius: 8) : const SizedBox(),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
        const Divider(thickness: 1, height: 50),
      ],
    );
  }
}
