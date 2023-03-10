// App core
import 'package:appcheap_flutter_core/appcheap_flutter_core.dart';

// Constants
import 'constants/constants.dart';

// Models
import 'models/models.dart';

class EnquiryRepository {
  final HttpClient _httpClient;

  EnquiryRepository(this._httpClient);

  /// **Get enquiry**
  ///
  /// **Param:**
  ///
  /// requestData: your request data
  ///
  /// **Returns:**
  ///
  /// Return list enquiry
  Future<List<Enquiry>> getEnquiry({required RequestData requestData}) async {
    try {
      List<dynamic> res = await _httpClient.get(
        Endpoints.enquiry,
        data: requestData,
      );

      List<Enquiry> enquirys = List<Enquiry>.of([]);

      if (res.isNotEmpty) {
        enquirys = res.map((e) => Enquiry.fromJson(e)).toList().cast<Enquiry>();
      }

      return enquirys;
    } catch (_) {
      rethrow;
    }
  }

  /// **Get enquiry detail**
  ///
  /// **Param:**
  ///
  /// requestData: passing id parameter
  ///
  /// **Returns:**
  ///
  /// Return enquiry detail
  Future<EnquiryReplyData> getEnquiryDetail({required int id, RequestData? requestData}) async {
    try {
      dynamic res = await _httpClient.get(
        "${Endpoints.enquiry}/$id",
        data: requestData,
      );

      EnquiryReplyData enquiryReplies = EnquiryReplyData.fromJson(res);

      return enquiryReplies;
    } catch (_) {
      rethrow;
    }
  }

  /// **Send messages**
  ///
  /// **Param:**
  ///
  /// requestData: your request data
  ///
  /// **Returns:**
  ///
  /// Return enquiry reply
  Future<EnquiryReplyData> updateReply({required int id, required RequestData requestData}) async {
    try {
      dynamic res = await _httpClient.post(
        "${Endpoints.enquiry}/$id/reply",
        data: requestData,
      );
      return EnquiryReplyData.fromJson(res);
    } catch (_) {
      rethrow;
    }
  }
}
