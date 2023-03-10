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
import '../bloc/review_detail_cubit.dart';

// View
import 'package:flutter_store_manager/themes.dart';
import 'widgets/review_detail_body.dart';

class ReviewDetailPage extends StatelessWidget with AppbarMixin {
  static const routeName = '/ReviewDetailPage';

  const ReviewDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic data = ModalRoute.of(context)!.settings.arguments;
    return BlocProvider<ReviewDetailCubit>(
      create: (_) => ReviewDetailCubit(
        reviewRepository: ReviewRepository(context.read<HttpClient>()),
        token: context.read<AuthenticationBloc>().state.token,
      ),
      child: ReviewDetailBody(
        review: data as Review,
      ),
    );
  }
}
