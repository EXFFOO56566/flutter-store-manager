import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/ui.dart';

import '../cubit/review_list_cubit.dart';

import 'review_list_body.dart';

class ReviewListPage extends StatelessWidget with AppbarMixin {
  static const routeName = '/review_list';
  const ReviewListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ReviewListCubit();
      },
      child: Scaffold(
        appBar: baseStyleAppBar(title: 'All Reviews'),
        body: const ReviewListBody(),
      ),
    );
  }
}
