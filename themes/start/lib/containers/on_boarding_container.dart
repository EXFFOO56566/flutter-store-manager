import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

int _duration = 500;

class OnBoardingContainer extends StatefulWidget {
  final int count;
  final Widget Function(BuildContext context, int index, VoidCallback nextAction) buttonControlBuilder;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final Widget skip;
  final double topSkip;
  final double bottomPagination;
  final double spacingButtonPagination;

  const OnBoardingContainer({
    Key? key,
    this.count = 3,
    required this.itemBuilder,
    required this.buttonControlBuilder,
    required this.skip,
    this.topSkip = 64,
    this.bottomPagination = 49,
    this.spacingButtonPagination = 41,
  })  : assert(count > 0),
        super(key: key);

  @override
  State<OnBoardingContainer> createState() => _OnBoardingContainerState();
}

class _OnBoardingContainerState extends State<OnBoardingContainer> {
  final SwiperController _controller = SwiperController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void nextAction() {
    _controller.next();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Swiper(
          controller: _controller,
          itemBuilder: (BuildContext context, int index) {
            return widget.itemBuilder(context, index);
          },
          duration: _duration,
          itemCount: widget.count,
          loop: false,
          pagination: SwiperCustomPagination(
            builder: (_, SwiperPluginConfig? config) {
              int activeIndex = config?.activeIndex ?? 0;
              return Container(
                padding: EdgeInsets.only(bottom: widget.bottomPagination),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    widget.buttonControlBuilder(context, activeIndex, nextAction),
                    SizedBox(height: widget.spacingButtonPagination),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: List.generate(
                        widget.count,
                        (int index) {
                          return _DotSwiper(active: activeIndex == index);
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        PositionedDirectional(top: widget.topSkip, end: 25, child: widget.skip),
      ],
    );
  }
}

class _DotSwiper extends StatelessWidget {
  final bool active;

  const _DotSwiper({
    Key? key,
    this.active = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double width = active ? 26 : 6;
    Color color = active ? theme.primaryColor : theme.dividerColor;

    return AnimatedContainer(
      width: width,
      height: 6,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: color),
      duration: Duration(milliseconds: _duration),
    );
  }
}
