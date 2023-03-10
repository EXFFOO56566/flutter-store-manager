import 'package:enquiry_repository/enquiry_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/themes.dart';

import '../../../authentication/bloc/authentication_bloc.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import '../cubit/enquiry_board_cubit.dart';
import 'enquiry_board_body.dart';

class EnquiryBoardPage extends StatelessWidget with AppbarMixin {
  static const routeName = '/enquiry_board';
  const EnquiryBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseStyleAppBar(title: AppLocalizations.of(context)!.translate('enquiry:text_enquiry')),
      body: BlocProvider(
        create: (context) => EnquiryBoardCubit(
          enquiryRepository: EnquiryRepository(context.read<HttpClient>()),
          token: context.read<AuthenticationBloc>().state.token,
        ),
        child: const EnquiryBoardBody(),
      ),
    );
  }
}
