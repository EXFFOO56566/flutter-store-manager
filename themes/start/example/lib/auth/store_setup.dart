import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import 'widgets/store_setup_step1.dart';
import 'widgets/store_setup_step2.dart';
import 'widgets/store_setup_step3.dart';

List<String> _tabs = ['Store', 'Payment', 'Ready!'];

class StoreSetupScreen extends StatefulWidget {
  static const routeName = '/store_setup';

  const StoreSetupScreen({Key? key}) : super(key: key);

  @override
  State<StoreSetupScreen> createState() => _StoreSetupScreenState();
}

class _StoreSetupScreenState extends State<StoreSetupScreen> with TickerProviderStateMixin, AppbarMixin {
  late TabController _tabController;

  int _step = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);

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

  void goStep(int step) {
    _tabController.animateTo(step);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseStyleAppBar(title: _step == 2 ? 'Vendor Submitted' : 'Store Setup'),
      body: StoreSetupContainer(
        tabbar: StoreSetupStep(
          items: _tabs,
          currentStep: _step,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        ),
        content: TabBarView(
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            StoreSetupStep1(
              goSkip: () => goStep(_step + 1),
              goStart: (address, showEmail) => goStep(_step + 1),
              padding: const EdgeInsets.fromLTRB(25, 10, 25, 25),
              paddingBottom: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            ),
            StoreSetupStep2(
              goSkip: () => goStep(_step + 1),
              goStart: () => goStep(_step + 1),
              padding: const EdgeInsets.fromLTRB(25, 20, 25, 25),
              paddingBottom: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            ),
            const StoreSetupStep3(),
          ],
        ),
      ),
    );
  }
}
