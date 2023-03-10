import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class SettingPersonSocialForm extends StatefulWidget {
  final Map<String, dynamic> social;

  const SettingPersonSocialForm({
    Key? key,
    this.social = const {},
  }) : super(key: key);

  @override
  State<SettingPersonSocialForm> createState() => _SettingPersonSocialFormState();
}

class _SettingPersonSocialFormState extends State<SettingPersonSocialForm> {
  late Map<String, dynamic> _social;

  @override
  void didChangeDependencies() {
    _social = widget.social;
    super.didChangeDependencies();
  }

  void changeSocial(String key, String value) {
    setState(() {
      _social = {
        ..._social,
        key: value,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    String initTwitter = _social['twitter'] ?? '';
    String initFacebook = _social['facebook'] ?? '';
    String initInstagram = _social['instagram'] ?? '';
    String initYoutube = _social['youtube'] ?? '';
    String initLinkedin = _social['linkedIn'] ?? '';
    String initGoogle = _social['google'] ?? '';
    String initSnapchat = _social['snapchat'] ?? '';
    String initPinterest = _social['pinterest'] ?? '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputTextField(
          label: 'Twitter',
          initialValue: initTwitter,
          keyboardType: TextInputType.url,
          onChanged: (String value) => changeSocial('twitter', value),
        ),
        const SizedBox(height: 15),
        InputTextField(
          label: 'Facebook',
          initialValue: initFacebook,
          keyboardType: TextInputType.url,
          onChanged: (String value) => changeSocial('facebook', value),
        ),
        const SizedBox(height: 15),
        InputTextField(
          label: 'Instagram',
          initialValue: initInstagram,
          keyboardType: TextInputType.url,
          onChanged: (String value) => changeSocial('instagram', value),
        ),
        const SizedBox(height: 15),
        InputTextField(
          label: 'Youtube',
          initialValue: initYoutube,
          keyboardType: TextInputType.url,
          onChanged: (String value) => changeSocial('youtube', value),
        ),
        const SizedBox(height: 15),
        InputTextField(
          label: 'Linkedin',
          initialValue: initLinkedin,
          keyboardType: TextInputType.url,
          onChanged: (String value) => changeSocial('linkedIn', value),
        ),
        const SizedBox(height: 15),
        InputTextField(
          label: 'Google Plus',
          initialValue: initGoogle,
          keyboardType: TextInputType.url,
          onChanged: (String value) => changeSocial('google', value),
        ),
        const SizedBox(height: 15),
        InputTextField(
          label: 'Snapchat',
          initialValue: initSnapchat,
          keyboardType: TextInputType.url,
          onChanged: (String value) => changeSocial('snapchat', value),
        ),
        const SizedBox(height: 15),
        InputTextField(
          label: 'Pinterest',
          initialValue: initPinterest,
          keyboardType: TextInputType.url,
          onChanged: (String value) => changeSocial('pinterest', value),
        ),
      ],
    );
  }
}
