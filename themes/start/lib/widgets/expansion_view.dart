import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:ui/widgets/container_secondary.dart';

const Duration _kExpand = Duration(milliseconds: 200);

class ExpansionView extends StatefulWidget {
  const ExpansionView({
    Key? key,
    required this.title,
    this.trailing,
    this.isSecondary = false,
    this.onExpansionChanged,
    this.isChevronIcon = true,
    this.children = const <Widget>[],
    this.initiallyExpanded = false,
    this.maintainState = false,
    this.expandedCrossAxisAlignment,
    this.expandedAlignment,
    this.childrenPadding,
    this.viewPadding,
  }) : super(key: key);

  final Widget title;
  final Widget? trailing;
  final bool isSecondary;
  final bool isChevronIcon;
  final ValueChanged<bool>? onExpansionChanged;
  final List<Widget> children;
  final bool initiallyExpanded;
  final bool maintainState;
  final AlignmentGeometry? expandedAlignment;
  final CrossAxisAlignment? expandedCrossAxisAlignment;
  final EdgeInsetsGeometry? childrenPadding;
  final EdgeInsetsGeometry? viewPadding;

  @override
  State<ExpansionView> createState() => _ExpansionViewState();
}

class _ExpansionViewState extends State<ExpansionView> with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween = CurveTween(curve: Curves.easeIn);

  late AnimationController _controller;
  late Animation<double> _heightFactor;

  bool _isExpanded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _heightFactor = _controller.drive(_easeInTween);

    _isExpanded = PageStorage.of(context)?.readState(context) as bool? ?? widget.initiallyExpanded;
    if (_isExpanded) {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
    widget.onExpansionChanged?.call(_isExpanded);
  }

  Widget buildView() {
    Widget icon = Icon(_isExpanded ? CommunityMaterialIcons.chevron_down : CommunityMaterialIcons.chevron_right);
    if (widget.isSecondary) {
      return InkWell(
        onTap: _handleTap,
        borderRadius: BorderRadius.circular(10),
        child: ContainerSecondary(
          borderRadius: BorderRadius.circular(10),
          constraints: const BoxConstraints(minHeight: 50),
          padding: widget.viewPadding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              Expanded(child: widget.title),
              if (widget.trailing != null) ...[
                const SizedBox(width: 8),
                widget.trailing ?? Container(),
              ],
              if (widget.isChevronIcon) ...[
                const SizedBox(width: 8),
                icon,
              ]
            ],
          ),
        ),
      );
    }
    return InkWell(
      onTap: _handleTap,
      child: Padding(
        padding: widget.viewPadding ?? const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Expanded(child: widget.title),
            if (widget.trailing != null) ...[
              const SizedBox(width: 8),
              widget.trailing ?? Container(),
            ],
            if (widget.isChevronIcon) ...[
              const SizedBox(width: 8),
              icon,
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        buildView(),
        ClipRect(
          child: Align(
            alignment: widget.expandedAlignment ?? Alignment.center,
            heightFactor: _heightFactor.value,
            child: child,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    final bool shouldRemoveChildren = closed && !widget.maintainState;

    final Widget result = Offstage(
      offstage: closed,
      child: TickerMode(
        enabled: !closed,
        child: Padding(
          padding: widget.childrenPadding ?? EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: widget.expandedCrossAxisAlignment ?? CrossAxisAlignment.center,
            children: widget.children,
          ),
        ),
      ),
    );

    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: shouldRemoveChildren ? null : result,
    );
  }
}
