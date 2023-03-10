import 'package:awesome_icons/awesome_icons.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:flutter_store_manager/types/types.dart';

List<Option> getReasonData(TranslateType translate) {
  return [
    Option(key: 'change_email_phone', name: translate('delete_account:text_reason_option_email')),
    Option(key: 'change_review_review', name: translate('delete_account:text_reason_option_review')),
    Option(key: 'no_use', name: translate('delete_account:text_reason_option_use')),
    Option(key: 'other', name: translate('delete_account:text_reason_option_other')),
  ];
}

List<Map<String, dynamic>> termData = [
  {
    'icon': FeatherIcons.book,
    'label_name': 'delete_account:text_term_post',
  },
  {
    'icon': FontAwesomeIcons.comments,
    'label_name': 'delete_account:text_term_comment',
  },
  {
    'icon': FontAwesomeIcons.receipt,
    'label_name': 'delete_account:text_term_order',
  },
];
