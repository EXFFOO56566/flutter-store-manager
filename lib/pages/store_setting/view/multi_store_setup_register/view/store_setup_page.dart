// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter_bloc/flutter_bloc.dart';

// Repository packages
import 'package:country_locale_repository/country_locale_repository.dart';
import 'package:country_repository/country_repository.dart';

// Bloc
import 'package:flutter_store_manager/address/address.dart';
import 'package:flutter_store_manager/authentication/authentication.dart';
import '../../../bloc/store_setting_bloc.dart';
import 'package:flutter_store_manager/settings/cubit/settings_cubit.dart';

// View
import 'widgets/store_setup_info.dart';
import 'widgets/store_setup_main.dart';
import 'widgets/store_setup_payment.dart';
import 'widgets/store_setup_policy.dart';
import 'widgets/store_setup_seo.dart';
import 'widgets/store_setup_social.dart';
import 'widgets/store_setup_success.dart';
import 'widgets/store_setup_support.dart';
import 'package:flutter_store_manager/pages/home/view/home_page.dart';

int _countStep = 8;

class StoreSetupScreen extends StatefulWidget {
  static const routeName = '/store-setup';

  const StoreSetupScreen({Key? key}) : super(key: key);

  @override
  StoreSetupScreenState createState() => StoreSetupScreenState();
}

class StoreSetupScreenState extends State<StoreSetupScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  int _step = 0;

  @override
  void initState() {
    super.initState();
    context.read<StoreSettingBloc>().add(const GetStoreSettingEvent());
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
            context.read<AuthenticationBloc>().add(SkipMultiStep());
            Navigator.pushNamed(context, HomePage.routeName);
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    HttpClient httpClient = context.read<HttpClient>();
    return BlocProvider<AddressCubit>(
      key: const Key("addressStoreSetup"),
      create: (_) => AddressCubit(
        countryRepository: CountryRepository(httpClient),
        countryLocaleRepository: CountryLocaleRepository(httpClient),
        token: context.read<AuthenticationBloc>().state.token,
        locale: context.read<SettingsCubit>().state.locate,
      ),
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
