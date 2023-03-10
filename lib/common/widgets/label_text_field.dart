import 'package:flutter/material.dart';
import 'package:flutter_store_manager/constants/dimension.dart';

class AppLabelTextField extends StatefulWidget {
  final String label;
  final String labelHint;
  final bool withAsterisk;
  final TextInputType textInputType;
  final String? labelValidation;
  final TextEditingController textFieldController;
  final bool readOnly;
  final bool isInvalid;
  final String? errorText;
  final ValueChanged? onValueChange;
  final int maxLength;
  final double? height;

  const AppLabelTextField(
      {Key? key,
      required this.label,
      required this.labelHint,
      required this.textFieldController,
      this.withAsterisk = true,
      this.textInputType = TextInputType.text,
      this.labelValidation,
      this.isInvalid = false,
      this.errorText = "",
      this.readOnly = false,
      this.onValueChange,
      this.maxLength = 255,
      this.height})
      : super(key: key);

  @override
  State<AppLabelTextField> createState() => _AppLabelTextFieldState();
}

class _AppLabelTextFieldState extends State<AppLabelTextField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (widget.label.isNotEmpty)
            ? RichText(
                text: TextSpan(
                    text: widget.label,
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: fontSize(context, 14)),
                    children: [
                      widget.withAsterisk
                          ? TextSpan(
                              text: ' *',
                              style: TextStyle(
                                  color: Colors.red, fontWeight: FontWeight.w400, fontSize: fontSize(context, 14)))
                          : const TextSpan()
                    ]),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
              )
            : const SizedBox.shrink(),
        (widget.label.isNotEmpty) ? SizedBox(height: height(context, 7)) : const SizedBox.shrink(),
        Focus(
          onFocusChange: (hasFocus) {
            if (hasFocus) {
              // do stuff
            } else {
              widget.textFieldController.text = widget.textFieldController.text.trim().replaceAll(RegExp(' +'), ' ');
            }
          },
          child: SizedBox(
            height: height(context, 75),
            child: TextFormField(
                maxLength: widget.maxLength,
                readOnly: widget.readOnly,
                enableInteractiveSelection: !widget.readOnly,
                controller: widget.textFieldController,
                obscureText: _isObscure && widget.textInputType == TextInputType.visiblePassword,
                keyboardType: widget.textInputType,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: widget.onValueChange,
                decoration: InputDecoration(
                    counterText: "",
                    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    hintText: widget.labelHint,
                    filled: true,
                    fillColor: Colors.white,
                    errorText: (widget.isInvalid) ? widget.errorText : null,
                    errorStyle: TextStyle(fontSize: fontSize(context, 12)),
                    hintStyle:
                        TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: fontSize(context, 14)),
                    suffixIcon: widget.textInputType == TextInputType.visiblePassword
                        ? IconButton(
                            color: Colors.blue,
                            icon: Icon(
                              _isObscure ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          )
                        : null)),
          ),
        ),
      ],
    );
  }
}
