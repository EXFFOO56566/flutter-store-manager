import 'store/store.dart';

abstract class SimpleStoreLocator {
  SimpleStore get createSimpleStorage;
}

class SimpleStoreModule {
  // Constructor
  SimpleStoreModule();

  // DI Providers:------------------------------------------------------------------------------------------------------
  /// A singleton preference provider.
  ///
  /// Calling it multiple times will return the same instance.
  SimpleStore providerSimpleStorage() => SharedPreferencesStore();
}
