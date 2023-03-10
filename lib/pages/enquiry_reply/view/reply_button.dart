import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/common/bloc/state_base.dart';
import 'package:flutter_store_manager/pages/enquiry_reply/cubit/enquiry_reply_cubit.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

class ReplyButton extends StatefulWidget {
  const ReplyButton({Key? key}) : super(key: key);

  @override
  ReplyButtonState createState() => ReplyButtonState();
}

class ReplyButtonState extends State<ReplyButton> with SnackMixin, LoadingMixin {
  final TextEditingController _controller = TextEditingController();
  bool enableButton = false;

  @override
  void initState() {
    _controller.addListener(() {
      setState(() {
        enableButton = _controller.text.isNotEmpty;
      });
    });
    super.initState();
  }

  void sendReply(int id) async {
    context.read<EnquiryReplyCubit>().updateReply(id: id, reply: _controller.text);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;

    return BlocListener<EnquiryReplyCubit, EnquiryReplyState>(
      listenWhen: (previous, current) => previous.replyState != current.replyState,
      listener: (context, state) {
        if (state.progress == 100) {
          _controller.clear();
        }
      },
      child: BlocBuilder<EnquiryReplyCubit, EnquiryReplyState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(25),
            width: double.infinity,
            child: TextFormField(
              controller: _controller,
              cursorColor: theme.primaryColor,
              decoration: InputDecoration(
                hintText: translate('enquiry:text_write'),
                filled: true,
                fillColor: theme.colorScheme.surface,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: theme.primaryColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: enableButton
                    ? state.replyState is LoadingState
                        ? buildLoading(radius: 8)
                        : InkResponse(
                            onTap: () {
                              if (state.replyState is! LoadingState) {
                                sendReply(ConvertData.stringToInt(state.data?.id));
                              }
                            },
                            child: Icon(
                              CommunityMaterialIcons.send,
                              size: 20,
                              color: theme.primaryColor,
                            ),
                          )
                    : null,
              ),
              maxLines: 5,
              minLines: 1,
            ),
          );
        },
      ),
    );
  }
}
