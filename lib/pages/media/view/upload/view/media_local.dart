/// Flutter library
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Bloc
import '../bloc/upload_cubit.dart';

class MediaLocal extends StatelessWidget {
  const MediaLocal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    return BlocBuilder<UploadCubit, UploadState>(
      builder: (context, state) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              Image.file(
                File(state.file.path!),
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: state.progress == 100 ? null : theme.cardColor.withOpacity(0.4),
                ),
                child: state.progress == 100
                    ? Container()
                    : Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 45,
                            height: 45,
                            child: CircularProgressIndicator(
                              value: state.progress / 100,
                            ),
                          ),
                          Text(
                            '${state.progress.floor()}%',
                            style: textTheme.bodyText2,
                          ),
                        ],
                      ),
              )
            ],
          ),
        );
      },
    );
  }
}
