import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:file_picker/file_picker.dart';

export 'package:html_editor_enhanced/src/html_editor_controller_unsupported.dart'
    if (dart.library.html) 'package:html_editor_enhanced/src/html_editor_controller_web.dart'
    if (dart.library.io) 'package:html_editor_enhanced/src/html_editor_controller_mobile.dart';

double _toolbarItemHeight = 36;

class InputHtml extends StatelessWidget {
  final HtmlEditorController controller;
  final String? hintText;
  final String? initValue;
  final ValueChanged<String> onChanged;
  final double height;
  final List<Widget> customToolbarButtons;
  final Function()? onInit;

  const InputHtml({
    Key? key,
    required this.controller,
    this.hintText,
    this.initValue,
    required this.onChanged,
    this.height = 300,
    this.customToolbarButtons = const [],
    this.onInit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return HtmlEditor(
      controller: controller,
      htmlEditorOptions: HtmlEditorOptions(
        autoAdjustHeight: true,
        shouldEnsureVisible: true,
        hint: hintText,
        adjustHeightForKeyboard: true,
        initialText: initValue,
      ),
      htmlToolbarOptions: HtmlToolbarOptions(
        defaultToolbarButtons: const [
          StyleButtons(),
          FontButtons(clearAll: false),
          ColorButtons(),
          ListButtons(listStyles: false),
          ParagraphButtons(textDirection: false, lineHeight: false, caseConverter: false),
          InsertButtons(
            video: false,
            audio: false,
            table: false,
            hr: false,
            otherFile: false,
          ),
        ],
        initiallyExpanded: true,
        toolbarPosition: ToolbarPosition.belowEditor,
        customToolbarButtons: customToolbarButtons,
        toolbarItemHeight: _toolbarItemHeight,
        separatorWidget: const VerticalDivider(indent: 2, endIndent: 2),
        dropdownIconColor: theme.textTheme.subtitle1?.color,
        buttonColor: theme.textTheme.subtitle1?.color,
        buttonSelectedColor: theme.primaryColor,
        buttonFillColor: theme.primaryColor.withOpacity(0.25),
        textStyle: theme.textTheme.bodyText2,
        onButtonPressed: (ButtonType type, bool? status, Function? updateStatus) {
          return true;
        },
        onDropdownChanged: (DropdownType type, dynamic changed, void Function(dynamic)? updateSelectedItem) {
          return true;
        },
        mediaLinkInsertInterceptor: (String url, InsertFileType type) {
          return false;
        },
        mediaUploadInterceptor: (PlatformFile file, InsertFileType type) async {
          //file extension (eg jpeg or mp4)
          return true;
        },
      ),
      callbacks: Callbacks(
        onChangeContent: (String? changed) {
          if (changed != null) {
            onChanged(changed);
          }
        },
        onImageUploadError: (FileUpload? file, String? base64Str, UploadError error) {
          if (file != null) {}
        },
        onNavigationRequestMobile: (String url) {
          return NavigationActionPolicy.ALLOW;
        },
        onInit: onInit,
      ),
      otherOptions: OtherOptions(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.zero,
          border: Border.all(width: 0, color: Colors.transparent),
          color: theme.colorScheme.surface,
        ),
      ),
      plugins: [
        SummernoteAtMention(
          getSuggestionsMobile: (String value) {
            var mentions = <String>['test1', 'test2', 'test3'];
            return mentions.where((element) => element.contains(value)).toList();
          },
          mentionsWeb: ['test1', 'test2', 'test3'],
          onSelect: (String value) {},
        ),
      ],
    );
  }
}

class InputHtmlButtonToolbar extends StatelessWidget {
  final IconData icon;
  const InputHtmlButtonToolbar({
    Key? key,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _toolbarItemHeight,
      height: _toolbarItemHeight,
      alignment: Alignment.center,
      child: Icon(icon),
    );
  }
}
