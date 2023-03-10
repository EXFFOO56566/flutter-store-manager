import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SmartFresher extends StatefulWidget {
  final Widget child;
  final Future Function()? onRefresh;
  final Future Function()? onLoadMore;
  final String? textLoadingFooter;

  const SmartFresher({
    Key? key,
    required this.child,
    this.onRefresh,
    this.onLoadMore,
    this.textLoadingFooter,
  }) : super(key: key);

  @override
  State<SmartFresher> createState() => _SmartFresherState();
}

class _SmartFresherState extends State<SmartFresher> {
  RefreshController? _refreshController;

  @override
  void initState() {
    super.initState();
    if (enableSmartRefresher) {
      _refreshController = RefreshController();
    }
  }

  @override
  void dispose() {
    _refreshController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!enableSmartRefresher) return widget.child;
    bool isRtl = Directionality.of(context) == TextDirection.rtl;
    return SmartRefresher(
      controller: _refreshController!,
      header: const ClassicHeader(
          refreshingIcon: CupertinoActivityIndicator(),
          refreshingText: "",
          releaseText: "",
          idleText: "",
          idleIcon: Icon(Icons.arrow_downward),
          completeText: "",
          releaseIcon: CupertinoActivityIndicator()),
      footer: ClassicFooter(
        iconPos: isRtl ? IconPosition.right : IconPosition.left,
        loadingIcon: const CupertinoActivityIndicator(),
        loadingText: widget.textLoadingFooter,
        idleText: "",
        idleIcon: const Icon(Icons.arrow_downward),
      ),
      onRefresh: onRefresh,
      onLoading: onLoadMore,
      enablePullDown: widget.onRefresh != null,
      enablePullUp: widget.onLoadMore != null,
      child: widget.child,
    );
  }

  bool get enableSmartRefresher {
    return widget.onRefresh != null || widget.onLoadMore != null;
  }

  void onRefresh() async {
    await widget.onRefresh?.call();
    _refreshController?.refreshCompleted();
  }

  void onLoadMore() async {
    await widget.onLoadMore?.call();
    _refreshController?.loadComplete();
  }
}
