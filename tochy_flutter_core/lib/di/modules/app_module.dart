import 'package:flutter/material.dart';

import 'store/store.dart';
import 'request/request.dart';

typedef BuildAppType = Widget Function(SimpleStore store, HttpClient httpClient);

abstract class AppLocator {
  Widget get createApp;
}

class AppModule {
  final BuildAppType buildApp;

  AppModule(this.buildApp);

  Widget providerApp(SimpleStore simpleStore, HttpClient httpClient) => buildApp(simpleStore, httpClient);
}
