class Strings {
  Strings._();

  /// On Android the titles appear above the task manager's app snapshots which are displayed when the user presses the
  /// "recent apps" button
  ///
  /// On the web it is used as the page title, which shows up in the browser's list of open tabs.
  ///
  /// On iOS this value cannot be used. CFBundleDisplayName from the app's Info.plist is referred to instead whenever
  /// present, CFBundleName
  static const String appTitle = 'Flutter Store Manager';

  /// This font family name declare the font in the pubspec.yaml
  static const String fontFamily = 'ProductSans';

  static List<String> dayOfWeek = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
}
