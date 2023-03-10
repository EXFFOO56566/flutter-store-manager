import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BaseSmartFresher extends StatefulWidget {
  final Widget child;
  final Future Function()? onRefresh;
  final Future Function()? onLoadMore;

  const BaseSmartFresher({
    Key? key,
    required this.child,
    this.onRefresh,
    this.onLoadMore,
  }) : super(key: key);

  @override
  BaseSmartFresherState createState() => BaseSmartFresherState();
}

class BaseSmartFresherState extends State<BaseSmartFresher> {
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
        loadingText: AppLocalizations.of(context)!.translate('common:text_loading'),
        idleText: "",
        idleIcon: null,
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
