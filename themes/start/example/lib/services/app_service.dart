import 'package:example/app.dart';

import 'helpers/persist_helper.dart';
import 'modules/preference_module.dart';

abstract class AppService implements PersisLocator {
  static Future<AppService> create(
    PreferenceModule preferenceModule,
  ) async {
    AppService service = await AppServiceInject.create(
      preferenceModule,
    );
    return service;
  }

  App get getApp;
}

class AppServiceInject implements AppService {
  final PreferenceModule _preferenceModule;

  PersistHelper? _singletonPersistHelper;

  AppServiceInject(this._preferenceModule);

  static Future<AppService> create(
    PreferenceModule preferenceModule,
  ) async {
    final injector = AppServiceInject(
      preferenceModule,
    );

    return injector;
  }

  App _createApp() => const App();

  PersistHelper _createPersistHelper() => _singletonPersistHelper ??= _preferenceModule.providerPersistHelper();

  @override
  PersistHelper get providerPersistHelper => _createPersistHelper();

  @override
  App get getApp => _createApp();
}
