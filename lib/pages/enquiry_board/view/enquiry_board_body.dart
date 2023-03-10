import 'package:community_material_icon/community_material_icon.dart';
import 'package:enquiry_repository/enquiry_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';

import '../../../common/widgets/base_smart_fresher.dart';
import '../../../themes.dart';
import '../../../types/types.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import '../../enquiry_reply/view/enquiry_reply_page.dart';
import '../cubit/enquiry_board_cubit.dart';
import '../widget/enquiry_board_item.dart';

class EnquiryBoardBody extends StatefulWidget {
  const EnquiryBoardBody({Key? key}) : super(key: key);
  @override
  EnquiryBoardBodyState createState() => EnquiryBoardBodyState();
}

class EnquiryBoardBodyState extends State<EnquiryBoardBody> {
  late EnquiryBoardCubit cubit;
  @override
  void initState() {
    cubit = context.read<EnquiryBoardCubit>();
    cubit.getEnquiry();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    return BlocBuilder<EnquiryBoardCubit, EnquiryBoardState>(
      builder: (context, state) {
        final canLoadMore = cubit.canLoadMore;
        final emptyData = state.actionState is! LoadingState && state.enquiryBoard.isEmpty;
        if (emptyData) {
          return NotificationEmptyView(
            icon: CommunityMaterialIcons.receipt,
            title: translate('enquiry:text_empty_enquiry'),
          );
        }
        return BaseSmartFresher(
          onRefresh: _refresh,
          onLoadMore: canLoadMore ? _loadMore : null,
          child: _body(state),
        );
      },
    );
  }

  Widget _body(EnquiryBoardState state) {
    List<Enquiry> emptyEnquiryBoard = List.generate(10, (index) => Enquiry()).toList();
    List<Enquiry> data = (state.enquiryBoard.isEmpty) ? emptyEnquiryBoard : state.enquiryBoard;

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        return EnquiryBoardItem(
          onTap: () {
            if (item.id != null) {
              Navigator.of(context).pushNamed(EnquiryReplyPage.routeName, arguments: item.id);
            }
          },
          enquiryBoard: item,
        );
      },
    );
  }

  Future _loadMore() async {
    await cubit.loadMore();
  }

  Future _refresh() async {
    await cubit.refresh();
  }
}
