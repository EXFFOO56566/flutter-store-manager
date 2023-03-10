class Endpoints {
  Endpoints._();

  // Login with Email and Username
  static const String login = "/app-builder/v1/login";

  // Register
  static const String register = "/app-builder/v1/register";

  // Forgot password
  static const String forgotPassword = "/app-builder/v1/lost-password";

  // Change password
  static const String changePassword = "/app-builder/v1/change-password";

  // Current
  static const String current = "/app-builder/v1/current";

  static const String deleteAccount = "/app-builder/v1/delete";

  static const String sendOptDeleteAccount = "/app-builder/v1/send-otp-delete";

  // Digits API: =======================================================================================================
  static const String digitsLogin = "/digits/v1/login_user";
  static const String digitsRegister = "/digits/v1/create_user";
  static const String digitsSendOtp = '/digits/v1/send_otp';
  static const String digitsReSendOtp = '/digits/v1/resend_otp';
  static const String digitsVerifyOtp = '/digits/v1/verify_otp';
}
