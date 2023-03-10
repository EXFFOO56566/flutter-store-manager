import 'package:flutter/material.dart';

class NotificationEmptyView extends StatelessWidget {
  final IconData icon;
  final String title;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final TextAlign? titleTextAlign;

  const NotificationEmptyView({
    Key? key,
    required this.icon,
    required this.title,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    this.titleTextAlign,
  }) : super(key: key);

  const factory NotificationEmptyView.button({
    Key? key,
    required IconData icon,
    required Widget titleWidget,
    required Widget contentWidget,
    double width,
    double height,
    double radius,
    Widget? textButton,
    VoidCallback? onPressed,
    Color? color,
    ButtonStyle? styleBtn,
    bool isButton,
  }) = _NotificationEmptyViewButton;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Center(
      child: Column(
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 50,
            color: theme.textTheme.caption?.color,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: theme.textTheme.subtitle1?.copyWith(color: theme.textTheme.caption?.color),
            textAlign: titleTextAlign ?? TextAlign.center,
          )
        ],
      ),
    );
  }
}

class _NotificationEmptyViewButton extends NotificationEmptyView {
  final Widget titleWidget;
  final double width;
  final double height;
  final double radius;
  final Widget contentWidget;
  final Widget? textButton;
  final VoidCallback? onPressed;
  final Color? color;
  final ButtonStyle? styleBtn;
  final bool isButton;

  const _NotificationEmptyViewButton({
    Key? key,
    required IconData icon,
    required this.titleWidget,
    required this.contentWidget,
    this.textButton,
    this.onPressed,
    this.width = 219,
    this.height = 129,
    this.radius = 110,
    this.color,
    this.styleBtn,
    this.isButton = true,
  }) : super(key: key, icon: icon, title: '');

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius),
                topRight: Radius.circular(radius),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.2, 1],
                colors: [
                  color?.withOpacity(0.1) ?? Theme.of(context).primaryColor.withOpacity(0.1),
                  Colors.transparent,
                ],
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 91),
                Icon(icon, color: color ?? Theme.of(context).primaryColor, size: 36),
              ],
            ),
          ),
          const SizedBox(height: 20),
          titleWidget,
          const SizedBox(height: 8),
          contentWidget,
          const SizedBox(height: 40),
          if (isButton)
            SizedBox(
              height: 48,
              child: ElevatedButton(onPressed: onPressed, style: styleBtn, child: textButton),
            )
        ],
      ),
    );
  }
}
