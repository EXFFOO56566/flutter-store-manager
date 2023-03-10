import 'package:example/screens/enquiry_board/view/enquiry_board_page.dart';
import 'package:example/screens/notification/view/notification_page.dart';
import 'package:example/screens/register/register.dart';
import 'package:example/screens/store_setup/multi_step_setup/store_setup_page.dart';
import 'package:flutter/material.dart';
import 'screens/screens.dart';

///
/// Define route
class Routes {
  Routes._();

  static routes() => <String, WidgetBuilder>{
        HomePage.routeName: (context) => const HomePage(),
        ForgotPasswordPage.routeName: (context) => const ForgotPasswordPage(),
        LoginPage.routeName: (context) => const LoginPage(),
        RegisterPage.routeName: (context) => const RegisterPage(),
        StoreSetupScreen.routeName: (context) => const StoreSetupScreen(),
        ReviewListPage.routeName: (context) => const ReviewListPage(),
        ReviewDetailPage.routeName: (context) => const ReviewDetailPage(),
        NotificationPage.routeName: (context) => const NotificationPage(),
        ReportPage.routeName: (context) => const ReportPage(),
        EnquiryBoardPage.routeName: (context) => const EnquiryBoardPage(),
      };
}
