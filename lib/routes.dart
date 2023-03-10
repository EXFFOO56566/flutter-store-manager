import 'package:flutter/material.dart';
import 'package:flutter_store_manager/pages/chat/chat.dart';
import 'package:flutter_store_manager/pages/store_setting/view/multi_store_setup_register/view/store_setup_page.dart';
import 'package:flutter_store_manager/pages/store_setting/view/setting_store_page.dart';
import 'package:flutter_store_manager/pages/store_setting/view/setup_policy/setup_policy_page.dart';
import 'package:flutter_store_manager/pages/store_setting/view/setup_seo/setup_seo_page.dart';
import 'package:flutter_store_manager/pages/store_setting/view/setup_social/setup_social_page.dart';
import 'package:flutter_store_manager/pages/store_setting/view/setup_support/setup_support.dart';
import 'package:flutter_store_manager/pages/store_setting/view/update_store_info/update_store_info.dart';
import 'package:flutter_store_manager/pages/store_setting/view/update_store_payment/update_store_payment.dart';
import 'pages/pages.dart';
import 'package:flutter_store_manager/pages/update_personal/view/update_personal_screen.dart';

///
/// Define routes
class Routes {
  Routes._();

  static routes() => <String, WidgetBuilder>{
        HomePage.routeName: (context) => const HomePage(),
        ProductAddPage.routeName: (context) => const ProductAddPage(),
        ProductEditPage.routeName: (context) => const ProductEditPage(),
        LoginMobileScreen.routeName: (context) => const LoginMobileScreen(),
        RegisterScreen.routeName: (context) => const RegisterScreen(),
        ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
        NotificationPage.routeName: (context) => const NotificationPage(),
        EnquiryBoardPage.routeName: (context) => const EnquiryBoardPage(),
        EnquiryReplyPage.routeName: (context) => const EnquiryReplyPage(),
        UpdatePersonalScreen.routeName: (context) => const UpdatePersonalScreen(),
        UpdatePersonalAddressScreen.routeName: (context) => const UpdatePersonalAddressScreen(),
        UpdatePasswordScreen.routeName: (context) => const UpdatePasswordScreen(),
        StoreSetupScreen.routeName: (context) => const StoreSetupScreen(),
        ReviewListPage.routeName: (context) => const ReviewListPage(),
        ReportPage.routeName: (context) => const ReportPage(),
        SettingStorePage.routeName: (context) => const SettingStorePage(),
        OrdersDetailPage.routeName: (context) => const OrdersDetailPage(),
        ReviewDetailPage.routeName: (context) => const ReviewDetailPage(),
        OrderChartPage.routeName: (context) => const OrderChartPage(),
        UpdateStoreInfoScreen.routeName: (context) => const UpdateStoreInfoScreen(),
        UpdateStorePaymentScreen.routeName: (context) => const UpdateStorePaymentScreen(),
        MediaListScreen.routeName: (context) => const MediaListScreen(),
        SetupPolicyPage.routeName: (context) => const SetupPolicyPage(),
        SetupSeoPage.routeName: (context) => const SetupSeoPage(),
        SetupSocialPage.routeName: (context) => const SetupSocialPage(),
        SetupSupportPage.routeName: (context) => const SetupSupportPage(),
        DeleteAccountPage.routeName: (context) => const DeleteAccountPage(),
      };

  static onGenerateRoute(settings) {
    // Handling chat detail router
    if (settings.name == ChatDetailScreen.routeName) {
      final args = settings.arguments;
      return MaterialPageRoute(
        builder: (context) {
          return ChatDetailScreen(args: args);
        },
      );
    }
    assert(false, 'Need to implement ${settings.name}');
    return null;
  }
}
