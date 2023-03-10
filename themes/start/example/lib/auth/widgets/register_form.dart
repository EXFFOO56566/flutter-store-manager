import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:ui/ui.dart';

import '../../screens.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _data = {};

  void changeData(String key, String value) {
    setState(() {
      _data = {
        ..._data,
        key: value,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputTextField(
            label: 'Email Address',
            decoration: InputDecoration(
              prefixIcon: Icon(
                CommunityMaterialIcons.email,
                size: 20,
                color: theme.textTheme.overline?.color,
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            onChanged: (String value) => changeData('email', value),
          ),
          const SizedBox(height: 15),
          InputTextField(
            label: 'Password',
            decoration: InputDecoration(
              prefixIcon: Icon(
                CommunityMaterialIcons.lock,
                size: 20,
                color: theme.textTheme.overline?.color,
              ),
            ),
            keyboardType: TextInputType.visiblePassword,
            onChanged: (String value) => changeData('password', value),
          ),
          const SizedBox(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: InputTextField(
                  label: 'First Name',
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      CommunityMaterialIcons.label,
                      size: 20,
                      color: theme.textTheme.overline?.color,
                    ),
                  ),
                  onChanged: (String value) => changeData('firstName', value),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: InputTextField(
                  label: 'Last Name',
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      CommunityMaterialIcons.label,
                      size: 20,
                      color: theme.textTheme.overline?.color,
                    ),
                  ),
                  onChanged: (String value) => changeData('lastName', value),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          InputTextField(
            label: 'Store Name',
            decoration: InputDecoration(
              prefixIcon: Icon(
                CommunityMaterialIcons.storefront,
                size: 20,
                color: theme.textTheme.overline?.color,
              ),
            ),
            onChanged: (String value) => changeData('storeName', value),
          ),
          const SizedBox(height: 15),
          InputTextField(
            label: 'Shop URL',
            decoration: InputDecoration(
              prefixIcon: Icon(
                CommunityMaterialIcons.link,
                size: 20,
                color: theme.textTheme.overline?.color,
              ),
            ),
            onChanged: (String value) => changeData('storeUrl', value),
          ),
          const SizedBox(height: 15),
          const LabelInput(title: 'Phone Number'),
          const InputPhoneNumber(
            hintText: '- - - - - - - - -',
            searchText: 'Search Country',
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.pushNamed(context, StoreSetupScreen.routeName);
                }
              },
              child: const Text('Register'),
            ),
          ),
        ],
      ),
    );
  }
}
