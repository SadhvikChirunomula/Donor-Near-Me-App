import 'dart:convert';

import 'package:dnmui/models/DonorListScreenModel/NotifyDonorRequest.dart';
import 'package:dnmui/models/DonorListScreenModel/RequestDonorRequest.dart';
import 'package:http/http.dart' as http;

class DonorListScreenService {
  Future<Map<String, dynamic>> addRequestToDb(
      RequestDonorRequest requestDonorRequest) async {
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

  Future<String> getFCMTokenOfUser(String mailid) async {
    http.Response response = await http
        .get('http://35.238.212.200:8080/user/fcmtoken?mailid=' + mailid);
    Map<String, dynamic> data = json.decode(response.body);
    if (data['error'] == null) {
      String fcmToken = data['fcmToken'].toString();
      print("Fetched Token is : " + fcmToken);
      return fcmToken;
    } else {
      return "";
    }
  }

  Future<Map<String, dynamic>> notifyDonor(
      NotifyDonorRequest notifyDonorRequest) async {
    String fcmToken = await getFCMTokenOfUser(notifyDonorRequest.mailid);
    print("FCM in Notify :" + fcmToken);
    http.Response response = await http
        .post('https://fcm.googleapis.com/fcm/send', headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization':
          'key=AAAA2XVt3bQ:APA91bGK8epXLGKOc5VXER1caFq4-oF_2_QiHgGzDlFZGq91AOrq9POPSdPW0JLIzzLowC8-vfApPx6atGigJlm2E9vBb0cujp5QsyWVsOrjU6N3eMb1IRArNTNiz3Bo_mxLPT7c6ScP'
    }, body: '''{
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
                "to": "$fcmToken"
              }''');
    // Map<String, dynamic> data = json.decode(response.body);

    return null;
  }
}
