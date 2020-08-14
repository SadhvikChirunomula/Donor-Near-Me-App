import 'dart:convert';

import 'package:dnmui/constants/Common.dart';
import 'package:dnmui/models/LoginScreen/AuthenticateRequest.dart';
import 'package:dnmui/models/LoginScreen/UpdateFcmTokenRequest.dart';
import 'package:http/http.dart' as http;

class LoginScreenService {
  Future<Map<String, dynamic>> authenticateApi(
      AuthenticateModel authenticateModel) async {
    http.Response response = await http.post(
        Common.apiEndPoint + '/authenticate',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'mailid': authenticateModel.mailid,
          'password': authenticateModel.password
        }));
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }

  updateFcmToken(UpdateFcmTokenRequest updateFcmTokenRequest) async {
    print("User Update FCM Token : " + updateFcmTokenRequest.fcmToken);
    http.Response response =
        await http.post(Common.apiEndPoint + '/updatefcm/login',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'mailid': updateFcmTokenRequest.mailid,
              'fcmToken': updateFcmTokenRequest.fcmToken
            }));
    Map<String, dynamic> data = json.decode(response.body);
    print("Update Status ");
  }
}
