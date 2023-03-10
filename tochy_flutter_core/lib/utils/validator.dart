class Validators {
  Validators._();

  static String emailPattern = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"
      "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})";

  static bool isDigit(String? input) {
    return isNotNullOrBlank(input) && RegExp(r'^\d+$').hasMatch(input!);
  }

  static bool isValidUsername(String? username) {
    return isNotNullOrBlank(username) &&
        isValidLength(username, min: 8, max: 20) &&
        !username!.contains(" ") &&
        RegExp(r'^[a-zA-Z0-9]+$').hasMatch(username);
  }

  static bool isValidPassword(String? password) {
    // Minimum 1 Upper case,
    // Minimum 1 lowercase,
    // Minimum 1 Numeric Number,
    // Minimum 1 Special Character,
    // Common Allow Character ( ! @ # $ & * ~ )
    return isNotNullOrBlank(password) &&
        isValidLength(password, min: 8, max: 20) &&
        RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$").hasMatch(password!);
  }

  static bool isValidEmail(String? email) {
    return email != null && RegExp(emailPattern).hasMatch(email);
  }

  static bool isValidPhone(String? phone) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    return isNotNullOrBlank(phone) && regExp.hasMatch(phone!);
  }

  static bool isNullOrBlank(String? text) {
    return text == null || text.trim().isEmpty;
  }

  static bool isNullOrEmpty(String? text) {
    return text == null || text.isEmpty;
  }

  static bool isNotNullOrBlank(String? text) {
    return !isNullOrBlank(text);
  }

  static bool isNotNullOrEmpty(String? text) {
    return !isNullOrEmpty(text);
  }

  static bool isValidLength(String? text, {int min = 0, int max = 255}) {
    return isNotNullOrBlank(text) && text!.length >= min && text.length <= max;
  }

  static bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  static bool isInt(String? s) {
    if (s == null) {
      return false;
    }
    return int.tryParse(s) != null;
  }
}
