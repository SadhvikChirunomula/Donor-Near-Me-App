import 'dart:convert';

import 'package:dnmui/constants/Common.dart';
import 'package:dnmui/models/OnLoginScreenModel/GetBloodRequestListRequest.dart';
import 'package:dnmui/models/OnLoginScreenModel/SubmitUserReviewRequest.dart';
import 'package:http/http.dart' as http;

class OnLoginScreenService {
  Future<Map<String, dynamic>> getBloodRequestsList(
      GetBloodRequestListRequest getBloodRequestListRequest) async {
    String baseUrl = Common.apiEndPoint +
        "/getbloodrequests?mailid=" +
        getBloodRequestListRequest.mailid;
    final response = await http.get(baseUrl);
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }

  submitUserReview(SubmitUserReviewRequest submitUserReviewRequest) async {
    String _baseUrl = Common.apiEndPoint + "/addreview";
    http.Response response = await http.post(_baseUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'mailid': submitUserReviewRequest.mailId,
          'stars': submitUserReviewRequest.stars,
          'comment': submitUserReviewRequest.comment
        }));
    Map<String, dynamic> data = json.decode(response.body);
  }
}
