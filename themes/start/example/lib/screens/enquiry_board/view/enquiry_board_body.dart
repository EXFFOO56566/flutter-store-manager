import 'package:community_material_icon/community_material_icon.dart';
import 'package:example/blocs/blocs.dart';
import 'package:example/widgets/enquiry_board_item.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ui/ui.dart';

import '../../../widgets/widgets.dart';
import '../cubit/enquiry_cubit.dart';
import '../models/enquiry_board.dart';

class EnquiryBoardBody extends StatefulWidget {
  const EnquiryBoardBody({Key? key}) : super(key: key);

  @override
  State<EnquiryBoardBody> createState() => _EnquiryBoardBodyState();
}

class _EnquiryBoardBodyState extends State<EnquiryBoardBody> {
  late EnquiryBoardCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<EnquiryBoardCubit>();
    _cubit.getEnquiryBoard();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future _loadMore() async {
    await _cubit.loadMore();
  }

  Future _refresh() async {
    await _cubit.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EnquiryBoardCubit, EnquiryBoardState>(
      builder: (context, state) {
        final canLoadMore = _cubit.canLoadMore;
        return state.actionState is! LoadingState && state.enquiryBoard.isEmpty
            ? const NotificationEmptyView(icon: CommunityMaterialIcons.receipt, title: 'Empty Enquiry Board')
            : BaseSmartFresher(
                onRefresh: _refresh,
                onLoadMore: canLoadMore ? _loadMore : null,
                child: _body(state, context),
              );
      },
    );
  }

  Widget _body(EnquiryBoardState state, BuildContext context) {
    List<EnquiryBoard> emptyEnquiryBoard = List.generate(_cubit.perPage, (index) => EnquiryBoard()).toList();
    List<EnquiryBoard> data = state.actionState is LoadingState ? emptyEnquiryBoard : state.enquiryBoard;
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double width = mediaQuery.size.width;
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        return Slidable(
          key: ValueKey(index),
          endActionPane: ActionPane(
            extentRatio: 116 / width,
            motion: const ScrollMotion(),
            children: [
              Expanded(child: ButtonSlidable(icon: CommunityMaterialIcons.check, onPressed: () {})),
              Expanded(
                child: ButtonSlidable(
                  icon: CommunityMaterialIcons.trash_can_outline,
                  colorIcon: const Color(0xFFFF5200),
                  onPressed: () {},
                ),
              )
            ],
          ),
          child: EnquiryBoardItem(
            onTap: () {
              if (item.id != null) {
                // Navigator.of(context).pushNamed(EnquiryReplyPage.routeName, arguments: item.id);
              }
            },
            enquiryBoard: item,
          ),
        );
      },
    );
  }
}
