// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Flutter library
import 'package:flutter/material.dart';

// Packages & Dependencies or Helper function
import 'package:flutter_bloc/flutter_bloc.dart';

// Repository packages
import 'package:google_place_repository/google_place_repository.dart';

// Bloc
import '../../../../bloc/store_setting_bloc.dart';

// View
import 'build_map.dart';
import 'item_location.dart';
import 'prediction_result.dart';

class ModalFindOnMap extends StatefulWidget {
  final bool isExpand;
  final bool isSearch;
  final String? hintTextSearch;
  final UserLocation? initUserLocation;
  const ModalFindOnMap(
      {Key? key, this.isExpand = false, this.isSearch = false, this.hintTextSearch, this.initUserLocation})
      : super(key: key);

  @override
  State<ModalFindOnMap> createState() => _ModalFindOnMapState();
}

class _ModalFindOnMapState extends State<ModalFindOnMap> {
  final TextEditingController _controller = TextEditingController();

  Widget buildView({required Widget child}) {
    if (widget.isExpand) {
      return Expanded(child: child);
    }
    return Flexible(child: child);
  }

  @override
  void initState() {
    if (widget.initUserLocation != null) {
      context.read<StoreSettingBloc>().add(UpdateUserLocationEvent(userLocation: widget.initUserLocation));
    }
    super.initState();
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
            BlocConsumer<StoreSettingBloc, StoreSettingState>(
              listenWhen: (previous, current) => previous.userLocationFromId != current.userLocationFromId,
              listener: (_, state) {
                if (state.userLocationFromId?.address != null) {
                  _controller.text = state.userLocationFromId!.address!;
                }
              },
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(25, 15, 25, 5),
                  child: TextFormField(
                    controller: _controller,
                    onChanged: (value) {
                      context.read<StoreSettingBloc>().add(SearchLocationChangedEvent(keyword: value));
                    },
                    decoration: InputDecoration(hintText: widget.hintTextSearch ?? 'Search'),
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
                            userLocation: state.userLocationFromId ?? widget.initUserLocation,
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
                            child: Text(AppLocalizations.of(context)!.translate('setup:text_update_location')),
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
