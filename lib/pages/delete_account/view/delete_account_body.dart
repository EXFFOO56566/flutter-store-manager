import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/authentication/authentication.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';
import 'package:flutter_store_manager/mixins/utility_mixin.dart';
import 'package:flutter_store_manager/tabs/tabs.dart';
import 'package:ui/ui.dart';

import '../cubit/delete_account_cubit.dart';
import '../widgets/widgets.dart';

class DeleteAccountBody extends StatefulWidget {
  const DeleteAccountBody({
    Key? key,
  }) : super(key: key);

  @override
  State<DeleteAccountBody> createState() => _DeleteAccountBodyState();
}

class _DeleteAccountBodyState extends State<DeleteAccountBody> with Utility, SnackMixin, TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  void nextStep() {
    if (_tabController.index < _tabController.length - 1) {
      int newIndex = _tabController.index + 1;

      setState(() {});

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _tabController.animateTo(newIndex);
      });
    }
  }

  void backStep() {
    if (_tabController.index > 0) {
      int newIndex = _tabController.index - 1;

      setState(() {});

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _tabController.animateTo(newIndex);
      });
    }
  }

  void logout() {
    Navigator.popUntil(context, ModalRoute.withName('/'));
    context.read<TabsCubit>().onItemTapped(0);
  }

  void deleteSuccess() {
    context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested());
    nextStep();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeleteAccountCubit, DeleteAccountState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            if (state.status is LoadedState) {
              logout();
            }
            return true;
          },
          child: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ReasonStep(nextStep: nextStep),
              TermStep(
                nextStep: () {
                  context.read<DeleteAccountCubit>().changeIsAgree(false);
                  nextStep();
                },
                backStep: backStep,
              ),
              AgreeStep(
                nextStep: () => nextStep(),
                backStep: backStep,
              ),
              OtpStep(
                nextStep: deleteSuccess,
                backStep: backStep,
              ),
              SuccessStep(onComplete: logout),
            ],
          ),
        );
      },
    );
  }
}
