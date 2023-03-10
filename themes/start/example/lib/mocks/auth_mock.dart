import 'configs.dart';
import 'data/data.dart';

Future loginApi(String user, String password) async {
  await Future.delayed(timeDelay);
  if (user != 'vendor' && password != 'vendor') {
    throw getDioError(path: '/login', message: 'The username or password you entered is incorrect.');
  }
  return userData;
}

Future forgotPasswordApi(String email) async {
  await Future.delayed(timeDelay);
  if (email == 'vendor@gmail.com') {
    throw getDioError(path: '/forgot_password', message: 'Not email');
  }
  return 'Success';
}

Future registerApi({String? username, String? password, String? firstName, String? lastName, String? email}) async {
  await Future.delayed(timeDelay);
  if (username != null && password != null && firstName != null && lastName != null && email != null) {
    if (username.isNotEmpty && password.isNotEmpty && firstName.isNotEmpty && lastName.isNotEmpty && email.isNotEmpty) {
      return userData;
    } else {
      throw getDioError(path: '/register', message: 'Please fill all field');
    }
  } else {
    throw getDioError(path: '/register', message: 'Please fill all field');
  }
}

Future updateStoreSetupApi({required Map<String, dynamic> data}) async {
  await Future.delayed(timeDelay);
  return 'Success';
}
