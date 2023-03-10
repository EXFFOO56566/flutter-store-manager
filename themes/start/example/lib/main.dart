import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_bloc_observer.dart';

import 'services/app_service.dart';
import 'services/modules/preference_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb ? HydratedStorage.webStorageDirectory : await getTemporaryDirectory(),
  );
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  AppService appServiceInject = await AppServiceInject.create(
    PreferenceModule(sharedPref: sharedPref),
  );

  HydratedBlocOverrides.runZoned(
    () => runApp(appServiceInject.getApp),
    blocObserver: AppBlocObserver(),
    storage: storage,
  );
}
