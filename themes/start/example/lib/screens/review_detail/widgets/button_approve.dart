import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:example/blocs/blocs.dart';
import 'package:ui/ui.dart';

import '../cubit/review_detail_cubit.dart';

class ButtonApprove extends StatelessWidget with SnackMixin {
  const ButtonApprove({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReviewDetailCubit, ReviewDetailState>(
      listenWhen: (previous, current) => previous.actionState != current.actionState,
      listener: (context, state) {
        if (state.actionState is ErrorState) {
          showError(context, 'Approve review fail');
        }
        if (state.actionState is LoadedState) {
          showSuccess(context, 'Approve review success');
        }
      },
      child: BlocBuilder<ReviewDetailCubit, ReviewDetailState>(
        builder: (_, state) {
          return ElevatedButton(
            onPressed: () => context.read<ReviewDetailCubit>().onApprove(),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            child: state.actionState is LoadingState
                ? const CupertinoActivityIndicator(color: Colors.white)
                : Text(state.data.approved == true ? 'Un-approve Review' : 'Approve Review'),
          );
        },
      ),
    );
  }
}
