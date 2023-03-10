import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:captcha_repository/captcha_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';
import 'package:flutter_store_manager/pages/captcha/cubit/captcha_cubit.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'package:ui/ui.dart';
import 'dart:convert';
import 'dart:typed_data';

double _widthCaptcha = 150;
double _heightCaptcha = 40;

class CaptchaWrap extends StatelessWidget {
  final Widget Function(Function openDialog) buildButton;
  final void Function(String captcha, String phrase) submit;
  final bool enable;

  const CaptchaWrap({
    Key? key,
    required this.buildButton,
    required this.submit,
    this.enable = true,
  }) : super(key: key);
  Future<void> _showMyDialog(BuildContext context) async {
    if (!enable) {
      return submit('', '');
    }
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: InkResponse(
                    onTap: () => Navigator.pop(context),
                    radius: 25,
                    child: const Icon(Icons.close),
                  ),
                ),
                const SizedBox(height: 16),
                Flexible(
                    child: BlocProvider(
                  create: (context) {
                    return CaptchaCubit(
                      captchaRepository: CaptchaRepository(context.read<HttpClient>()),
                    );
                  },
                  child: _CirillaCaptchaForm(
                    submit: (captcha, phrase) {
                      Navigator.pop(context);
                      submit(captcha, phrase);
                    },
                  ),
                )),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildButton(
      () => _showMyDialog(context),
    );
  }
}

class _CirillaCaptchaForm extends StatefulWidget {
  final void Function(String captcha, String phrase) submit;
  const _CirillaCaptchaForm({
    Key? key,
    required this.submit,
  }) : super(key: key);

  @override
  State<_CirillaCaptchaForm> createState() => _CirillaCaptchaFormState();
}

class _CirillaCaptchaFormState extends State<_CirillaCaptchaForm> with LoadingMixin {
  late CaptchaCubit cubit;

  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    cubit = context.read<CaptchaCubit>();
    cubit.getCaptcha();
  }

  Widget buildCaptcha() {
    return BlocBuilder<CaptchaCubit, CaptchaState>(
      builder: (context, state) {
        String value = state.captcha?['captcha'] ?? '';
        Uint8List bytesImage = const Base64Decoder().convert(value.split(',').last);
        return ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.memory(
            bytesImage,
            width: _widthCaptcha,
            height: _heightCaptcha,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }

  Widget buildLoadingCaptcha() {
    return SizedBox(
      height: _heightCaptcha,
      width: _widthCaptcha,
      child: buildLoadingElevatedSurface(),
    );
  }

  Widget buildErrorCaptcha(TranslateType translate) {
    return SizedBox(
      height: _heightCaptcha,
      width: _widthCaptcha,
      child: Center(
        child: Text(
          translate('captcha:text_captcha_error'),
          style: const TextStyle(color: Colors.red),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;

    return BlocBuilder<CaptchaCubit, CaptchaState>(
      builder: (context, state) {
        if (state.status is! LoadedState) {
          _controller.clear();
        }
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (state.error?.isNotEmpty == true) ...[
                Text(state.error!, style: theme.textTheme.caption?.copyWith(color: Colors.red)),
                const SizedBox(height: 8),
              ],
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 3, color: theme.dividerColor),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: state.status is! LoadedState
                        ? buildLoadingCaptcha()
                        : state.captcha != null
                            ? buildCaptcha()
                            : buildErrorCaptcha(translate),
                  ),
                  const SizedBox(width: 12),
                  InkResponse(
                    onTap: () => state.status is LoadingState ? null : cubit.getCaptcha(),
                    radius: 25,
                    child:
                        Icon(Icons.sync, color: state.status is LoadingState ? theme.dividerColor : theme.primaryColor),
                  )
                ],
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _controller,
                validator: (value) {
                  if (value!.isEmpty) {
                    return translate('captcha:text_captcha_validate_empty');
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: translate('captcha:text_captcha_txt')),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: state.captcha != null
                      ? () {
                          if (!state.loadingValidate && _formKey.currentState!.validate()) {
                            String phrase = state.captcha?['phrase'] ?? '';
                            cubit.validateCaptcha(
                              {
                                'captcha': _controller.text,
                                'phrase': phrase,
                              },
                              () => widget.submit(_controller.text, phrase),
                            );
                          }
                        }
                      : null,
                  child:
                      state.loadingValidate ? buildLoadingElevated() : Text(translate('captcha:text_captcha_submit')),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
