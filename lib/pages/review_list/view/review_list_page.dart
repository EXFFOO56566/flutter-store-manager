// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter_bloc/flutter_bloc.dart';

// Repository packages
import 'package:review_repository/review_repository.dart';

// Bloc
import 'package:flutter_store_manager/authentication/authentication.dart';
import '../bloc/review_cubit.dart';

// View
import 'widgets/reviews_body.dart';
import 'package:flutter_store_manager/themes.dart';

class ReviewListPage extends StatelessWidget with AppbarMixin {
  static const routeName = '/ReviewPage';

  const ReviewListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReviewCubit>(
      create: (_) => ReviewCubit(
        reviewRepository: ReviewRepository(context.read<HttpClient>()),
        token: context.read<AuthenticationBloc>().state.token,
      ),
      child: Scaffold(
        appBar: baseStyleAppBar(title: AppLocalizations.of(context)!.translate('account:text_review')),
        body: const ReviewsBody(),
      ),
    );
  }
}
