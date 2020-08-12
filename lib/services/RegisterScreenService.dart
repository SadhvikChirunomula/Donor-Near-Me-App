import 'dart:convert';

import 'package:dnmui/constants/Common.dart';
import 'package:dnmui/models/RegisterScreenModel/GetUserOtpRequest.dart';
import 'package:dnmui/models/RegisterScreenModel/SendOtpRequest.dart';
import 'package:dnmui/models/RegisterScreenModel/ValidateOtpRequest.dart';
import 'package:http/http.dart' as http;

class RegisterScreenService {
  Future<Map<String, dynamic>> validateOtp(
      ValidateOtpRequest validateOtpRequest) async {
    http.Response response = await http.post(
        'http://35.238.212.200:8080/validateotp',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'mailid': validateOtpRequest.mailid,
          'otp': validateOtpRequest.otp
        }));
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }

  Future<http.Response> sendOtpToUser(SendOtpRequest sendOtpRequest) async {
    http.Response response =
        await http.post('http://35.238.212.200:8080/sendotp',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'mailid': sendOtpRequest.mailid,
            }));
    return response;
  }

  Future<Map<String, dynamic>> getUserOtp(GetUserOtpRequest getUserOtpRequest) async {
    http.Response response = await http.get(
        'http://35.238.212.200:8080/getuserotp?mailid=' + getUserOtpRequest.mailid,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }

  Future<Map<String, dynamic>> getBloodGroupsList() async {
    var response = await http.get(Common.apiEndPoint + '/list/bloodgroups');
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }
}
