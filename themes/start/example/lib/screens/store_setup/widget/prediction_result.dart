import 'package:example/screens/store_setup/bloc/store_setting_bloc.dart';
import 'package:example/screens/store_setup/model/prediction.dart';
import 'package:example/screens/store_setup/widget/item_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PredictLocationResults extends StatelessWidget {
  const PredictLocationResults({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreSettingBloc, StoreSettingState>(
      builder: (context, state) {
        if (state.listPredictionLocation != null) {
          if (state.listPredictionLocation!.isNotEmpty) {
            return ListView.builder(
              itemBuilder: (context, index) {
                Prediction item = state.listPredictionLocation![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ItemLocation(
                    title: item.structuredFormatting.mainText,
                    subTitle: item.structuredFormatting.secondaryText,
                    search: state.keywordLocation ?? '',
                    onTap: () {
                      context.read<StoreSettingBloc>().add(GetPlaceFromIdEvent(placeId: item.placeId));
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  ),
                );
              },
              itemCount: state.listPredictionLocation!.length,
            );
          }
        }
        return const Text("Enter your address");
      },
    );
  }
}
