import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import 'widgets/login_mobile_code_form.dart';

class LoginMobileScreen extends StatelessWidget with AppbarMixin {
  static const routeName = '/login_mobile';

  const LoginMobileScreen({Key? key}) : super(key: key);

  void clickGetCode(BuildContext context) async {
    String? value = await showModalBottomSheet<String?>(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        MediaQueryData mediaQuery = MediaQuery.of(context);
        double height = mediaQuery.size.height - mediaQuery.viewInsets.top - mediaQuery.viewInsets.bottom;

        return Container(
          constraints: BoxConstraints(maxHeight: height * 0.8, minHeight: height * 0.3),
          margin: mediaQuery.viewInsets,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(25, 24, 25, 32),
            child: LoginMobileCode(
              title: 'Enter code\nsent to your phone',
              subtitle: RichText(
                text: TextSpan(
                  text: 'We sent it to the number',
                  children: [
                    TextSpan(
                      text: ' +84 123 456 ***',
                      style: Theme.of(context).textTheme.bodyText2,
                    )
                  ],
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
              form: LoginMobileCodeForm(
                clickVerifyCode: (String code) {},
              ),
            ),
          ),
        );
      },
    );
    if (value != null) {}
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: baseStyleAppBar(title: 'Login Mobile'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(25, 12, 25, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text('Login with your number phone', style: theme.textTheme.caption),
            ),
            const SizedBox(height: 24),
            const LabelInput(title: 'Phone Number'),
            const InputPhoneNumber(
              initCountryCode: 'VN',
              hintText: '- - - - - - - - -',
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => clickGetCode(context),
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
