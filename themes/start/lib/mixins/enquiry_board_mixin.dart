import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ui/ui.dart';

class EnquiryBoardMixin {
  Widget buildImage({required ThemeData theme, bool isLoading = false, String url = ''}) {
    if (isLoading) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: const AnimatedShimmer(height: 60, width: 60),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: CacheImageView(
        image: url,
        width: 60,
        height: 60,
        errorWidget: const ImageErrorUserView(),
      ),
    );
  }

  Widget buildName({String? name, required ThemeData theme, bool isLoading = false}) {
    if (isLoading) {
      return LayoutBuilder(
        builder: (_, BoxConstraints constraints) {
          double width = constraints.maxWidth != double.infinity ? constraints.maxWidth : 180;
          return AnimatedShimmer(height: 17, width: width);
        },
      );
    }
    return Text(
      name ?? '',
      style: theme.textTheme.subtitle2,
    );
  }

  Widget buildDateTimeEmail({
    String? date,
    String? time,
    String? email,
    required ThemeData theme,
    bool isLoading = false,
  }) {
    if (isLoading) {
      return Wrap(
        spacing: 8,
        children: const [
          AnimatedShimmer(height: 15, width: 58),
          AnimatedShimmer(height: 15, width: 58),
        ],
      );
    }
    return Wrap(
      spacing: 10,
      runSpacing: 5,
      children: [
        Text(date ?? '', style: theme.textTheme.overline),
        Text(time ?? '', style: theme.textTheme.overline),
        Text(email ?? '', style: theme.textTheme.overline),
      ],
    );
  }

  Widget buildEnquiry({String? enquiry, required ThemeData theme, bool isLoading = false}) {
    if (isLoading) {
      return LayoutBuilder(
        builder: (_, BoxConstraints constraints) {
          double width = constraints.maxWidth != double.infinity ? constraints.maxWidth : 245;
          return AnimatedShimmer(height: 17, width: width);
        },
      );
    }
    return Html(
      data: '<div>${enquiry ?? ''}</div>'.replaceAll('\n', '</br>'),
      shrinkWrap: true,
      style: {
        'html': Style(padding: EdgeInsets.zero, margin: EdgeInsets.zero),
        'body': Style(padding: EdgeInsets.zero, margin: EdgeInsets.zero),
        'div': Style.fromTextStyle(theme.textTheme.caption ?? const TextStyle()),
      },
    );
  }

  Widget buildReply({String? reply, required Color color, bool isLoading = false}) {
    if (isLoading) {
      return const AnimatedShimmer(
        height: 21,
        width: 45,
        radius: 12,
      );
    }
    return Badge(
      title: reply ?? 'Un-replied',
      padHorizontal: 8,
      background: color,
      size: 21,
    );
  }
}
