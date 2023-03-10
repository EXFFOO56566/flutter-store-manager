import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class ReviewDetailScreen extends StatelessWidget with AppbarMixin, ReviewMixin {
  static const routeName = '/review-detail';

  const ReviewDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: baseStyleAppBar(title: 'Detail Review'),
      body: ReviewDetailContainer(
        content: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(25, 10, 25, 25),
          child: ReviewDetailContent(
            avatar: buildAvatar(
                url:
                    'https://static.vecteezy.com/packs/media/components/global/search-explore-nav/img/vectors/term-bg-1-666de2d941529c25aa511dc18d727160.jpg'),
            name: buildName(name: 'Tom Masey', theme: theme),
            dateTime: buildDateTime(date: '29/10/2019', time: '10:00 AM', theme: theme),
            rating: buildRating(rating: '5.0', color: const Color(0xFF2BBD69)),
            description: Text(
              'Qui dolor reprehenderit duis nostrud incididunt cupidatat dolore excepteur enim aliqua commodo. Fugiat reprehenderit sit in duis ad quis. Reprehenderit officia mollit dolore est tempor dolore occaecat. Quis nostrud qui id ex eiusmod eu ut est veniam sunt esse adipisicing. Duis do culpa dolor velit velit ea id tempor Lorem.',
              style: theme.textTheme.caption,
            ),
          ),
        ),
        buttonBottom: Center(
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('Approve Review'),
          ),
        ),
      ),
    );
  }
}
