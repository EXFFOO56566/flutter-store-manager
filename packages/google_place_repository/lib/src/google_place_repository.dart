// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Packages & Dependencies or Helper function
import 'package:dio/dio.dart';
import 'package:google_place_repository/src/service/helper/google_place_helper.dart';

// Models
import 'package:google_place_repository/src/models/models.dart';

class GooglePlaceRepository {
  final String googleMapApiKey;

  GooglePlaceRepository({required this.googleMapApiKey});
  late GooglePlaceApiHelper googlePlaceApiHelper;
  void init() {
    BaseOptions options = BaseOptions(
      baseUrl: 'https://maps.googleapis.com/',
      connectTimeout: 5000,
      receiveTimeout: 3000,
      queryParameters: {'key': googleMapApiKey},
    );
    Dio dio = Dio(options);
    googlePlaceApiHelper = GooglePlaceApiHelper(dioClient: DioCli(dio));
  }

  /// **Get place auto complete**
  ///
  /// **Param:**
  ///
  /// keyword: keyword of place
  ///
  /// **Returns:**
  ///
  /// Return list place
  Future<List<Prediction>> getPlaceAutocomplete({
    required String? keyword,
    RequestCancel? requestCancel,
  }) async {
    try {
      var res = (await googlePlaceApiHelper.getPlaceAutocomplete(
        queryParameters: {
          'input': keyword,
        },
        cancelToken: requestCancel,
      ));
      return res['predictions'].map<Prediction>((p) => Prediction.fromJson(p)).toList();
    } catch (_) {
      rethrow;
    }
  }

  /// **Get place detail from id**
  ///
  /// **Param:**
  ///
  /// placeId: id of place
  ///
  /// **Returns:**
  ///
  /// Return UserLocation
  Future<UserLocation> getPlaceDetailFromId({
    required String? placeId,
    RequestCancel? requestCancel,
  }) async {
    try {
      var res = (await googlePlaceApiHelper.getPlaceDetailFromId(
        queryParameters: {
          'place_id': placeId,
        },
        cancelToken: requestCancel,
      ));
      Place place = Place.fromJson(res['result']);
      UserLocation userLocation = UserLocation(
          address: place.address, lat: place.location.latitude, lng: place.location.longitude, id: place.placeId);
      return userLocation;
    } catch (_) {
      rethrow;
    }
  }
}
