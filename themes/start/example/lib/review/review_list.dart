import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../widgets/review_item.dart';

class ReviewListScreen extends StatelessWidget with AppbarMixin {
  static const routeName = '/review-list';

  const ReviewListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseStyleAppBar(title: 'All Reviews'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
        child: Column(
          children: List.generate(
            10,
            (index) => const ReviewItem(
              padding: EdgeInsets.symmetric(vertical: 18),
            ),
          ),
        ),
      ),
    );
  }
}
