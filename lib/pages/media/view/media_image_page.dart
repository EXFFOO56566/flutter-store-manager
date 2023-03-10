import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/pages/media/media.dart';
import 'package:flutter_store_manager/themes.dart';
import 'package:flutter_store_manager/types/types.dart';
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';
import 'package:media_repository/media_repository.dart';

import 'media_alert_dialog.dart';

Color _scaffoldBackground = const Color(0xFF1D2338);
Color _appBarIconBackground = const Color.fromRGBO(255, 255, 255, 0.8);
Color _appbarColor = Colors.black;

class MediaImagePage extends StatelessWidget with AppbarMixin, SnackMixin, LoadingMixin {
  final Media? item;
  final MediaCubit? mediaCubit;

  const MediaImagePage({
    Key? key,
    this.item,
    this.mediaCubit,
  }) : super(key: key);

  void _delete(BuildContext context, dynamic item) async {
    String? data = await showCupertinoDialog<String?>(
      context: context,
      builder: (BuildContext ctx) {
        return const MediaAlertDialog();
      },
    );
    if (data == 'yes') {
      mediaCubit?.deleteMedia(item!.id);
    }
  }

  Widget buildBackgroundButton({required Widget child}) {
    return Ink(
      width: 40,
      height: 40,
      decoration: BoxDecoration(color: _appBarIconBackground, shape: BoxShape.circle),
      child: child,
    );
  }

  Widget buildIconAppBar({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return buildBackgroundButton(
      child: IconButton(
        icon: Icon(icon),
        iconSize: 19,
        splashRadius: 20,
        onPressed: onPressed,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;

    return Theme(
      data: theme.copyWith(
        scaffoldBackgroundColor: _scaffoldBackground,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: _appbarColor),
          titleTextStyle: TextStyle(color: _appbarColor),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 90,
          leading: Column(
            children: [
              buildIconAppBar(
                icon: Icons.arrow_back,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          actions: [
            BlocListener<MediaCubit, MediaState>(
              bloc: mediaCubit,
              listenWhen: (previous, current) => previous.deleting != current.deleting,
              listener: (context, state) {
                if (state.deleting == 'complete') {
                  Navigator.of(context).pop();
                  showSuccess(context, translate('message:text_delete_media_success'));
                }
                if (state.deleting == 'error') {
                  showError(context, translate('message:text_delete_media_fail'));
                }
              },
              child: BlocBuilder<MediaCubit, MediaState>(
                bloc: mediaCubit,
                builder: (context, state) {
                  return state.deleting == 'pending'
                      ? buildBackgroundButton(
                          child: buildLoading(
                            radius: 10,
                            color: _appbarColor,
                          ),
                        )
                      : buildIconAppBar(
                          icon: Icons.delete,
                          onPressed: () {
                            if (state.deleting != 'pending') {
                              _delete(context, item);
                            }
                          },
                        );
                },
              ),
            ),
            const SizedBox(width: 25),
          ],
          automaticallyImplyLeading: true,
        ),
        extendBodyBehindAppBar: true,
        body: Center(
          child: Hero(
            tag: 'media-image-${item?.id}',
            child: CacheImageView(
              image: item?.url ?? '',
              fit: BoxFit.contain,
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
