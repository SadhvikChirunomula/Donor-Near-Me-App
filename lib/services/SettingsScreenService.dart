import 'dart:convert';

import 'package:dnmui/models/SettingsScreenModel/GetUserDetailsRequest.dart';
import 'package:dnmui/models/SettingsScreenModel/UpdateUserRequest.dart';
import 'package:http/http.dart' as http;

class SettingsScreenService{
  Future<Map<String, dynamic>> getUserDetails(GetUserDetailsRequest getUserDetailsRequest) async {
    var response = await http.get('http://35.238.212.200:8080/getdetails/user?mailid=' + getUserDetailsRequest.mailid);
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }

  Future<http.Response> updateUserDetails(String mailid, UpdateUserRequest updateUserRequest) async {
    http.Response response =
    await http.put('http://35.238.212.200:8080/updateUser?mailid='+mailid,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'mailid':mailid
        },
        body: jsonEncode(<String, String>{
          'bloodgroup': updateUserRequest.bloodGroup,
          'mail_notification': updateUserRequest.mailNotification,
          'mailid': updateUserRequest.mailid,
          'phonenumber': updateUserRequest.mobileNumber,
          'sms_notification': updateUserRequest.smsNotification,
          'username': updateUserRequest.fullName,
          'city':updateUserRequest.city,
          'country':updateUserRequest.country,
          'district':updateUserRequest.district,
          'state':updateUserRequest.state,
          'town':updateUserRequest.town,
          'pincode':updateUserRequest.pincode,
          'password':updateUserRequest.password
        }));
    return response;
  }
}