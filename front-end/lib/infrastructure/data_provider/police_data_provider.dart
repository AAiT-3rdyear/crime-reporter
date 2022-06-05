import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/Crime_models/report.dart';

class PoliceDataProvider {
  String baseUrl = 'http://10.0.2.2:3000';


  Future<dynamic> getOngoingCrimes(user) async {
    var response = await http.get(
      Uri.parse(baseUrl + '/police/reportedCrimes/$user/ongoing'),
    );
    if (response.statusCode == 200) {
      var crimeList = response;
      return crimeList;
    } else {
      throw Exception("Failed to get crime");
    }
  }


  Future<dynamic> getSolvedCrimes(user) async {
    var response = await http.get(
      Uri.parse(baseUrl + '/police/reportedCrimes/$user/solved'),
    );
    if (response.statusCode == 200) {
      var crimeList = response;
      return crimeList;
    } else {
      throw Exception("Failed to get crime");
    }
  }

  dynamic getReportedCrime(String jeson) {
    dynamic json = jsonDecode(jeson);
    dynamic reportedCrime = Report.fromJson(json);
    return reportedCrime;
  }


  Future<dynamic> deleteCrime(id) async {
    var response = await http.get(
      Uri.parse(baseUrl + '/police/crime/delete/$id'),
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception("Failed to get crime");
    }
  }

  Future<dynamic> moveToOngoing(id) async {
    var response = await http.patch(
      Uri.parse(baseUrl + '/police/ongoing/$id'),
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception("Failed to move crime");
      }
  }

  Future<dynamic> moveToSolved(id) async {
    var response = await http.patch(
      Uri.parse(baseUrl + '/police/solved/$id'),
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception("Failed to move crime");
    }
  }
}
