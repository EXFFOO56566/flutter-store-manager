import 'package:example/blocs/blocs.dart';
import 'package:example/common/model/image_data.dart';
import 'package:example/common/widgets/image_picker/images_picker_input.dart';
import 'package:example/common/widgets/input_html_editor/bloc/input_html_editor_bloc.dart';
import 'package:example/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/ui.dart';

class InputHtmlEditorPage extends StatefulWidget {
  final String? hintText;
  final String? initValue;
  final ValueChanged<String> onChanged;

  const InputHtmlEditorPage({
    Key? key,
    this.hintText,
    this.initValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<InputHtmlEditorPage> createState() => _InputHtmlEditorPageState();
}

class _InputHtmlEditorPageState extends State<InputHtmlEditorPage> with AppbarMixin {
  final HtmlEditorController _controller = HtmlEditorController();
  late String _value;

  @override
  void initState() {
    _value = widget.initValue ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double height = mediaQuery.size.height - mediaQuery.viewPadding.top - mediaQuery.viewPadding.bottom;

    return BlocProvider(
      create: (context) {
        return InputHtmlEditorBloc();
      },
      child: BlocConsumer<InputHtmlEditorBloc, InputHtmlEditorState>(
        builder: (BuildContext context, state) {
          return Stack(
            children: [
              GestureDetector(
                onTap: () {
                  if (!kIsWeb) {
                    _controller.clearFocus();
                  }
                },
                child: Scaffold(
                  appBar: baseStyleAppBar(
                    title: '',
                    actions: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () => widget.onChanged(_value),
                            style: ElevatedButton.styleFrom(
                              textStyle: theme.textTheme.overline,
                              minimumSize: const Size(0, 29),
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                            ),
                            child: const Text("Done"),
                          ),
                        ],
                      ),
                      const SizedBox(width: 25),
                    ],
                  ),
                  body: Container(
                    color: theme.colorScheme.surface,
                    child: SafeArea(
                      top: false,
                      child: InputHtml(
                        controller: _controller,
                        hintText: widget.hintText,
                        initValue: _value,
                        onChanged: (String data) {
                          setState(() {
                            _value = data;
                          });
                        },
                        height: height,
                        customToolbarButtons: [
                          ImagesPickerInput(
                            onChanged: (List<ImageData> images) {
                              context.read<InputHtmlEditorBloc>().add(ImageChanged(images));
                            },
                            onDeleted: (_) {},
                            showIcon: true,
                          ),
                        ],
                        onInit: () {
                          _controller.setFocus();
                          _controller.editorController!.evaluateJavascript(
                              source:
                                  "document.getElementsByClassName('note-editable')[0].style.backgroundColor='${ConvertData.fromColor(theme.scaffoldBackgroundColor)}';document.getElementsByClassName('note-editable')[0].style.color='${ConvertData.fromColor(theme.textTheme.subtitle1?.color ?? Colors.black)}';document.getElementsByClassName('note-editable')[0].style.padding='20px 25px';");
                        },
                      ),
                    ),
                  ),
                ),
              ),
              if (state.status is LoadingState)
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: theme.colorScheme.surface.withOpacity(0.6),
                    alignment: Alignment.center,
                    child: CupertinoActivityIndicator(
                      color: theme.primaryColor,
                    ),
                  ),
                )
            ],
          );
        },
        listener: (context, state) {
          if (state.status is LoadedState && state.imageUrls.isNotEmpty) {
            for (int i = 0; i < state.imageUrls.length; i++) {
              _controller.insertNetworkImage(state.imageUrls[i]);
            }
          }
        },
      ),
    );
  }
}
