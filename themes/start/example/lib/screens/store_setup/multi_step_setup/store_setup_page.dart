import 'package:example/screens/home/home.dart';
import 'package:example/screens/store_setup/bloc/store_setting_bloc.dart';
import 'package:example/screens/store_setup/multi_step_setup/view/store_setup_info.dart';
import 'package:example/screens/store_setup/multi_step_setup/view/store_setup_main.dart';
import 'package:example/screens/store_setup/multi_step_setup/view/store_setup_payment.dart';
import 'package:example/screens/store_setup/multi_step_setup/view/store_setup_policy.dart';
import 'package:example/screens/store_setup/multi_step_setup/view/store_setup_seo.dart';
import 'package:example/screens/store_setup/multi_step_setup/view/store_setup_social.dart';
import 'package:example/screens/store_setup/multi_step_setup/view/store_setup_success.dart';
import 'package:example/screens/store_setup/multi_step_setup/view/store_setup_support.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

int _countStep = 8;

class StoreSetupScreen extends StatefulWidget {
  static const routeName = '/store-setup';

  const StoreSetupScreen({Key? key}) : super(key: key);

  @override
  State<StoreSetupScreen> createState() => _StoreSetupScreenState();
}

class _StoreSetupScreenState extends State<StoreSetupScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  int _step = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _countStep, vsync: this);

    _tabController.addListener(() {
      if (_tabController.index != _step) {
        setState(() {
          _step = _tabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void goNextStep() {
    _tabController.animateTo(_step + 1);
  }

  Widget buildWidget(int index, BuildContext context) {
    switch (index) {
      case 1:
        return StoreSetupInfo(
          onNextStep: goNextStep,
        );
      case 2:
        return StoreSetupPayment(
          onNextStep: goNextStep,
        );
      case 3:
        return StoreSetupPolicy(
          onNextStep: goNextStep,
        );
      case 4:
        return StoreSetupSupport(
          onNextStep: goNextStep,
        );
      case 5:
        return StoreSetupSeo(
          onNextStep: goNextStep,
        );
      case 6:
        return StoreSetupSocial(onNextStep: goNextStep);
      case 7:
        return const StoreSetupSuccessPage();
      default:
        return StoreSetupMain(
          onGoStoreSetup: goNextStep,
          onGoDashboard: () {
            Navigator.pushNamed(context, HomePage.routeName);
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return StoreSettingBloc(token: "");
      },
      child: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
          _countStep,
          (int index) => buildWidget(index, context),
        ),
      ),
    );
  }
}
