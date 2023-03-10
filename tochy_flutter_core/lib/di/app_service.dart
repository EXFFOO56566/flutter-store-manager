import 'package:flutter/material.dart';

import 'modules/modules.dart';

abstract class AppService implements AppLocator, SimpleStoreLocator, NetworkLocator {
  static Future<AppService> create(
    AppModule appModule,
    SimpleStoreModule simpleStoreModule,
    NetworkModule networkModule,
  ) async {
    AppService service = await AppServiceInject.create(
      appModule,
      simpleStoreModule,
      networkModule,
    );
    return service;
  }
}

class AppServiceInject implements AppService {
  final AppModule _appModule;
  final SimpleStoreModule _simpleStoreModule;
  final NetworkModule _networkModule;

  Widget? _app;
  SimpleStore? _simpleStore;
  HttpClient? _httpClient;

  AppServiceInject(
    this._appModule,
    this._simpleStoreModule,
    this._networkModule,
  );

  static Future<AppService> create(
    AppModule appModule,
    SimpleStoreModule simpleStoreModule,
    NetworkModule networkModule,
  ) async {
    final injector = AppServiceInject(
      appModule,
      simpleStoreModule,
      networkModule,
    );
    return injector;
  }

  SimpleStore _createSimpleStore() => _simpleStore ??= _simpleStoreModule.providerSimpleStorage();

  HttpClient _createHttpClient() => _httpClient ??= _networkModule.providerHttpClient();

  Widget _createApp() => _app ??= _appModule.buildApp(_createSimpleStore(), _createHttpClient());

  @override
  Widget get createApp => _createApp();

  @override
  SimpleStore get createSimpleStorage => _createSimpleStore();

  @override
  HttpClient get createHttpClient => _createHttpClient();
}
