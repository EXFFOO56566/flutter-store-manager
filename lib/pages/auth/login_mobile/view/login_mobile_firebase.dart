import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:formz/formz.dart';

// Themes & UI
import '../bloc/login_mobile_bloc.dart';
import 'widgets/login_mobile_code_form.dart';
import 'widgets/widgets.dart';

class LoginMobileFirebase extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final String type;

  LoginMobileFirebase({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          avoidPrint(snapshot.error);
          return const Text('Error');
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return _LoginMobileFirebase(type: type);
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const CircularProgressIndicator();
      },
    );
  }
}

///
/// Login SMS Firebase
class _LoginMobileFirebase extends StatefulWidget {
  final String type;

  const _LoginMobileFirebase({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  __LoginMobileFirebaseState createState() => __LoginMobileFirebaseState();
}

class __LoginMobileFirebaseState extends State<_LoginMobileFirebase> with SnackMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        avoidPrint('User is currently signed out!');
      } else {
        avoidPrint('User logged!');
        _handleLoginAndRegister(user);
      }
    });
  }

  _handleLoginAndRegister(User user) async {
    if (widget.type == "register") {
      context.read<LoginMobileBloc>().add(RegisterSubmitted(_callback));
    } else {
      IdTokenResult idTokenResult = await user.getIdTokenResult();
      if (idTokenResult.token != null) {
        if (mounted) context.read<LoginMobileBloc>().add(LoginSubmitted(idTokenResult.token!, _callback));
      }
    }
  }

  Future<void> _callback([bool navigate = true, dynamic e]) async {
    await _auth.signOut();
    if (e != null && mounted) showError(context, e is RequestError ? e.message : e);
    if (navigate && mounted) Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  _setLoading(bool value) {
    setState(() {
      _loading = value;
    });
  }

  void _onSubmit() async {
    LoginMobileState state = context.read<LoginMobileBloc>().state;

    // Exit if phone not validate
    if (state.status.isInvalid) {
      return;
    }

    PhoneNumber? phoneNumber = state.phone.value;
    String phone = phoneNumber!.number!.startsWith('+') ? phoneNumber.number! : phoneNumber.completeNumber;
    _setLoading(true);

    try {
      // For web
      if (kIsWeb) {
        ConfirmationResult confirmationResult = await _auth.signInWithPhoneNumber(phone);
        await showModalBottomSheet<String>(
          context: context,
          isScrollControlled: true,
          builder: (context) {
            MediaQueryData mediaQuery = MediaQuery.of(context);
            double height = mediaQuery.size.height - mediaQuery.viewInsets.top - mediaQuery.viewInsets.bottom;
            return Container(
              constraints: BoxConstraints(maxHeight: height * 0.8, minHeight: height * 0.3),
              margin: mediaQuery.viewInsets,
              child: LoginMobileCodeForm(
                phone: phone,
                onVerify: (String smsCode) async {
                  try {
                    await confirmationResult.confirm(smsCode);
                  } catch (e) {
                    return;
                  }
                },
                onResent: () async {
                  await _auth.verifyPhoneNumber(
                    phoneNumber: phone,
                    verificationFailed: (FirebaseAuthException error) {},
                    codeSent: (String verificationId, int? forceResendingToken) {},
                    codeAutoRetrievalTimeout: (String verificationId) {},
                    verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
                  );
                },
              ),
            );
          },
        );
        _setLoading(false);
      } else {
        await _auth.verifyPhoneNumber(
          phoneNumber: phone,
          verificationCompleted: (PhoneAuthCredential credential) async {
            _setLoading(false);
            // Automatic handling of the SMS code on Android devices.
            await _auth.signInWithCredential(credential);
          },
          verificationFailed: (FirebaseAuthException e) {
            _setLoading(false);
            showError(context, e.message);
          },
          codeSent: (String verificationId, int? resendToken) async {
            await showModalBottomSheet(
              isDismissible: false,
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                MediaQueryData mediaQuery = MediaQuery.of(context);
                double height = mediaQuery.size.height - mediaQuery.viewInsets.top - mediaQuery.viewInsets.bottom;

                return Container(
                  constraints: BoxConstraints(maxHeight: height * 0.8, minHeight: height * 0.3),
                  margin: mediaQuery.viewInsets,
                  child: LoginMobileCodeForm(
                    phone: phone,
                    onVerify: (String smsCode) async {
                      try {
                        await _onVerify(verificationId, smsCode);
                      } catch (e) {
                        rethrow;
                      }
                    },
                    onResent: () async {
                      try {
                        await _auth.verifyPhoneNumber(
                          phoneNumber: phone,
                          forceResendingToken: resendToken,
                          verificationFailed: (FirebaseAuthException error) {},
                          codeSent: (String verificationId, int? forceResendingToken) {},
                          codeAutoRetrievalTimeout: (String verificationId) {},
                          verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
                        );
                      } catch (e) {
                        rethrow;
                      }
                    },
                  ),
                );
              },
            );
            _setLoading(false);
          },
          timeout: const Duration(seconds: 60),
          codeAutoRetrievalTimeout: (String verificationId) {
            _setLoading(false);
            avoidPrint('codeAutoRetrievalTimeout $verificationId');
          },
        );
      }
    } on UnimplementedError catch (e) {
      _setLoading(false);
      showError(context, e.message);
    }
  }

  /// Handle verify sms code
  Future<void> _onVerify(String verificationId, String smsCode) async {
    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      await _auth.signInWithCredential(phoneAuthCredential);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoginMobileForm(loading: _loading, onSubmit: _onSubmit);
  }
}
