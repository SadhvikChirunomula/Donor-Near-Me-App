import 'dart:convert';

import 'package:dnmui/constants/Common.dart';
import 'package:dnmui/models/OnLoginScreenModel/GetBloodRequestListRequest.dart';
import 'package:http/http.dart' as http;

class OnLoginScreenService{
  Future<Map<String,dynamic>> getBloodRequestsList(GetBloodRequestListRequest getBloodRequestListRequest) async {
    String baseUrl =
        Common.apiEndPoint+"/getbloodrequests?mailid="+getBloodRequestListRequest.mailid;
    final response = await http.get(baseUrl);
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }
}