import 'package:flutter/material.dart';
import '../screens.dart';

import 'wcfm_widgets/store_setup_info.dart';
import 'wcfm_widgets/store_setup_main.dart';
import 'wcfm_widgets/store_setup_payment.dart';
import 'wcfm_widgets/store_setup_policy.dart';
import 'wcfm_widgets/store_setup_seo.dart';
import 'wcfm_widgets/store_setup_social.dart';
import 'wcfm_widgets/store_setup_success.dart';
import 'wcfm_widgets/store_setup_support.dart';

int _countStep = 8;

class StoreSetupWcfmScreen extends StatefulWidget {
  static const routeName = '/store-setup-wcfm';

  const StoreSetupWcfmScreen({Key? key}) : super(key: key);

  @override
  State<StoreSetupWcfmScreen> createState() => _StoreSetupWcfmScreenState();
}

class _StoreSetupWcfmScreenState extends State<StoreSetupWcfmScreen> with TickerProviderStateMixin {
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

  Widget buildWidget(int index) {
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
          onGoDashboard: () => Navigator.pushNamed(context, HomeScreen.routeName),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: _tabController,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(
        _countStep,
        (int index) => buildWidget(index),
      ),
    );
  }
}
