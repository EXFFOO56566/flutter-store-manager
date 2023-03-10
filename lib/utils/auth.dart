import 'package:flutter_store_manager/constants/auth.dart';
import 'package:user_repository/user_repository.dart';

///
/// Check role user
///
bool checkRoleUserVendor(User user) {
  bool isCheck = false;
  List<String> roles = user.roles;

  for (int i = 0; i < roles.length; i++) {
    String role = roles[i];
    if (loginRole.contains(role)) {
      isCheck = true;
      break;
    }
  }

  return isCheck;
}
