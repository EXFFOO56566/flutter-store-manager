import 'package:example/screens/enquiry_board/cubit/enquiry_cubit.dart';
import 'package:example/screens/enquiry_board/view/enquiry_board_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/ui.dart';

class EnquiryBoardPage extends StatelessWidget with AppbarMixin {
  static const routeName = '/enquiry-board';
  const EnquiryBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EnquiryBoardCubit(),
      child: Scaffold(
        appBar: baseStyleAppBar(title: 'Enquiry Board'),
        body: const EnquiryBoardBody(),
      ),
    );
  }
}
