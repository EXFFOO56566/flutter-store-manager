import 'package:appcheap_flutter_core/di/di.dart';
import 'package:enquiry_repository/enquiry_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/authentication/authentication.dart';
import 'package:flutter_store_manager/themes.dart';

import '../cubit/enquiry_reply_cubit.dart';
import 'enquiry_reply_body.dart';

class EnquiryReplyPage extends StatelessWidget with AppbarMixin {
  static const routeName = '/enquiry_reply';
  const EnquiryReplyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic id = ModalRoute.of(context)!.settings.arguments;
    return BlocProvider(
      create: (context) => EnquiryReplyCubit(
        enquiryRepository: EnquiryRepository(context.read<HttpClient>()),
        token: context.read<AuthenticationBloc>().state.token,
      ),
      child: EnquiryReplyBody(id: id),
    );
  }
}
