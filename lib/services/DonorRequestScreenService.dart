import 'dart:convert';
import 'package:dnmui/constants/Common.dart';
import 'package:dnmui/models/DonorRequestScreenModel/GetAvailableDonorsListRequest.dart';
import 'package:dnmui/models/DonorRequestScreenModel/GetCitiesListRequest.dart';
import 'package:dnmui/models/DonorRequestScreenModel/GetDistrictsListRequest.dart';
import 'package:dnmui/models/DonorRequestScreenModel/GetStatesListRequest.dart';
import 'package:dnmui/models/DonorRequestScreenModel/GetTownsListRequest.dart';
import 'package:dnmui/models/OnLoginScreenModel/GetBloodRequestListRequest.dart';
import 'package:http/http.dart' as http;

class DonorRequestScreenService {
  Future<Map<String, dynamic>> getStatesList(
      GetStatesListRequest getStatesListRequest) async {
    var response = await http.get(Common.apiEndPoint +
        '/areas/list/states?country=' +
        getStatesListRequest.country);
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }

  Future<Map<String, dynamic>> getDistrictsList(
      GetDistrictsListRequest getDistrictsListRequest) async {
    var response = await http.get(Common.apiEndPoint +
        '/areas/list/districts?state=' +
        getDistrictsListRequest.state);
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }

  Future<Map<String, dynamic>> getCitiesList(
      GetCitiesListRequest getCitiesListRequest) async {
    var response = await http.get(Common.apiEndPoint +
        '/areas/list/cities?district=' +
        getCitiesListRequest.district);
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }

  Future<Map<String, dynamic>> getTownsList(
      GetTownsListRequest getTownsListRequest) async {
    var response = await http.get(Common.apiEndPoint +
        '/areas/list/towns?city=' +
        getTownsListRequest.city);
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }

  Future<Map<String, dynamic>> getBloodGroupsList() async {
    var response = await http.get(Common.apiEndPoint + '/list/bloodgroups');
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }

  Future<Map<String, dynamic>> getAvailableDonors(
      GetAvailableDonorsListRequest getAvailableDonorsListRequest) async {
    var response = await http.get(Common.apiEndPoint +
        '/getdonors/available?country=' +
        getAvailableDonorsListRequest.country +
        '&state=' +
        getAvailableDonorsListRequest.state +
        '&district=' +
        getAvailableDonorsListRequest.district +
        '&city=' +
        getAvailableDonorsListRequest.city +
        '&bloodgroup=' +
        getAvailableDonorsListRequest.bloodGroup +
        '&town=' +
        getAvailableDonorsListRequest.town);
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }
}
