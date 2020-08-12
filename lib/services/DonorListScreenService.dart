import 'dart:convert';

import 'package:dnmui/models/DonorListScreenModel/NotifyDonorRequest.dart';
import 'package:dnmui/models/DonorListScreenModel/RequestDonorRequest.dart';
import 'package:http/http.dart' as http;


class DonorListScreenService{
  Future<Map<String, dynamic>> addRequestToDb(RequestDonorRequest requestDonorRequest) async {
    http.Response response =
    await http.post('http://35.238.212.200:8080/donorrequest',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'donorId': requestDonorRequest.donorId,
          'message': requestDonorRequest.message,
          'receipentId': requestDonorRequest.recipientId,
        }));
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }

  Future<Map<String, dynamic>> notifyDonor(NotifyDonorRequest notifyDonorRequest) async {
    http.Response response = await http.post(
        'https://fcm.googleapis.com/fcm/send',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
          'key=AAAA2XVt3bQ:APA91bGj9EPpcVmG4Q0ZDJ7EdqBrHWlVi7PSiN_SlSt_15ywGcLj6GIOVlseYujhzESj2TlLglZKpjFp1n4B3AsrehZMZgLYZ8FVcZnglRiJmRiQNazHGmQrmSZjFLOsZDuae-HJZDo-'
        },
        body: '''{
                "notification": {
                  "body": "Someone Around You Need Blood",
                  "title": "Need Blood"
                },
                "priority": "high",
                "data": {
                  "click_action": "FLUTTER_NOTIFICATION_CLICK",
                  "id": "1",
                  "status": "done"
                },
                "to": "cufxOXvkp-4:APA91bFYTAw6VcPL_LD-oPDKMy52AQ4COxuX3d_J3M2_pPTB7OBzUiXovKdQDff7sXWhDC2boiOXU9QfcDH_T9BxXgQXDfNgBqugfElws3xntsgzykWfTQotBFz44-0i0U1Y45WtaBlV"
              }''');
    Map<String, dynamic> data = json.decode(response.body);

    return data;
  }
}