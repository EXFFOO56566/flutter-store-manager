import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/authentication/authentication.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:media_repository/media_repository.dart';
import 'package:personal_repository/personal_repository.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:flutter_store_manager/stores/global/bloc/global_bloc.dart';
import '../bloc/update_personal_bloc.dart';
import '../widgets/update_personal_body.dart';

class UpdatePersonalScreen extends StatelessWidget with AppbarMixin {
  static const routeName = '/update_personal';

  const UpdatePersonalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseStyleAppBar(title: AppLocalizations.of(context)!.translate('account:text_personal')),
      body: BlocProvider(
        create: (_) {
          return UpdatePersonalBloc(
              personalRepository: PersonalRepository(context.read<HttpClient>()),
              mediaRepository: MediaRepository(context.read<HttpClient>()),
              token: context.read<AuthenticationBloc>().state.token,
              user: context.read<AuthenticationBloc>().state.user,
              value: context.read<GlobalBloc>().state.stores['update_personal'],
              onChanged: (store) => context.read<GlobalBloc>().add(GlobalStoreChanged('update_personal', store)));
        },
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: const UpdatePersonalBody(),
        ),
      ),
    );
  }
}
