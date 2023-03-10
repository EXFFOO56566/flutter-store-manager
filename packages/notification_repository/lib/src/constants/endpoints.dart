class Endpoints {
  Endpoints._();

  // Get Notification
  static const String getNotification = "/wcfmmp/v1/notifications";

  //Get Count Notification
  static const String getCountNotification = "/app-builder/v1/vendors/count-notifications";

  //Read Notification
  static const String updateReadNotification = "/app-builder/v1/vendors/messages-mark-read";

  //Delete Notification
  static const String deleteNotification = "/app-builder/v1/vendors/messages-delete";
}
