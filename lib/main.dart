import 'package:appcheap_flutter_core/service/messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
export 'package:firebase_analytics/firebase_analytics.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'app.dart';
import 'app_bloc_observer.dart';
import 'constants/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializePushNotification();

  AppServiceInject inject = AppServiceInject(
    AppModule(
      (SimpleStore simpleStore, HttpClient httpClient) => App(
        simpleStore: simpleStore,
        httpClient: httpClient,
      ),
    ),
    SimpleStoreModule(),
    NetworkModule(baseUrl: '$baseUrl$restPrefix'),
  );

  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb ? HydratedStorage.webStorageDirectory : await getTemporaryDirectory(),
  );

  HydratedBlocOverrides.runZoned(
    () => runApp(inject.createApp),
    blocObserver: AppBlocObserver(),
    storage: storage,
  );
}
