import 'package:example/screens/store_setup/bloc/store_setting_bloc.dart';
import 'package:example/screens/store_setup/model/user_location.dart';
import 'package:example/screens/store_setup/widget/build_map.dart';
import 'package:example/screens/store_setup/widget/item_location.dart';
import 'package:example/screens/store_setup/widget/prediction_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ModalFindOnMap extends StatelessWidget {
  final bool isExpand;
  final bool isSearch;
  final String? hintTextSearch;
  final UserLocation? initUserLocation;

  const ModalFindOnMap(
      {Key? key, this.isExpand = false, this.isSearch = false, this.hintTextSearch, this.initUserLocation})
      : super(key: key);

  Widget buildView({required Widget child}) {
    if (isExpand) {
      return Expanded(child: child);
    }
    return Flexible(child: child);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<StoreSettingBloc, StoreSettingState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(25, 15, 25, 5),
                  child: TextFormField(
                    initialValue: "",
                    onChanged: (value) {
                      context.read<StoreSettingBloc>().add(SearchLocationChangedEvent(keyword: value));
                    },
                    decoration: InputDecoration(hintText: hintTextSearch ?? 'Search'),
                  ),
                );
              },
            ),
            buildView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 15, 25, 10),
                child: BlocBuilder<StoreSettingBloc, StoreSettingState>(
                  builder: (context, state) {
                    if (state.showPredictLocation) {
                      return const SizedBox(height: 900, child: PredictLocationResults());
                    }
                    return Column(
                      children: [
                        Expanded(
                          child: BuildMapLocation(
                            userLocation: state.userLocationFromId ?? initUserLocation,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 50,
                          child: _buildPlaceInfo(location: state.userLocationFromId),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context, state.userLocationFromId);
                            },
                            child: const Text("Update location"),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceInfo({required UserLocation? location}) {
    String subtitle = location?.address ?? '';
    List<String> splitSubtitle = subtitle.split(',');
    String title = splitSubtitle.isNotEmpty ? splitSubtitle[0] : '';

    return ItemLocation(
      primaryIcon: true,
      title: title,
      subTitle: subtitle,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      isDivider: false,
    );
  }
}
