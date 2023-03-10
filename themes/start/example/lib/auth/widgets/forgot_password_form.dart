import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:ui/widgets/label_input.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({
    Key? key,
  }) : super(key: key);

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _txtEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Enter your account email address and we\'ll send instructions on how to reset your password',
            style: theme.textTheme.caption,
          ),
          const SizedBox(height: 20),
          const LabelInput(title: "Email Address"),
          TextFormField(
            controller: _txtEmail,
            decoration: InputDecoration(
              prefixIcon: Icon(
                CommunityMaterialIcons.email,
                size: 20,
                color: theme.textTheme.overline?.color,
              ),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {}
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
