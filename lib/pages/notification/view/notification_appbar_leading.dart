import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_manager/pages/pages.dart';

import 'package:flutter_store_manager/themes.dart';

class NotificationAppbarLeading extends StatelessWidget with AppbarMixin {
  const NotificationAppbarLeading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      buildWhen: (previous, current) => previous.updateData != current.updateData,
      builder: (context, state) {
        return leading(
          onPressed: () {
            Navigator.pop(context, state.updateData);
          },
        );
      },
    );
  }
}
