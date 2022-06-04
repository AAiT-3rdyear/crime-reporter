import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:crime_reporter/domain/models.dart';

class UserDataProvider {
  String baseUrl = 'http://10.0.2.2:3000';
  final storage = const FlutterSecureStorage();

  Future<dynamic> getUser(dynamic username, dynamic password) async {
    var response = await http.post(
      Uri.parse(baseUrl + '/login'),
      headers: {"Content.type": "application/json"},
      body: {'username': username, 'password': password},
    );
    if (response.statusCode == 200) {
      const storage = FlutterSecureStorage();
      await storage.write(
          key: "token", value: "${jsonDecode(response.body)["user"]['token']}");
      dynamic json = jsonDecode(response.body);
      dynamic user = User.fromJson(json['user']);
      return user;
    } else {
      return response.statusCode;
    }
  }

  Future<dynamic> signUpUser(Map<String, dynamic> body) async {
    var response = await http.post(
      Uri.parse(baseUrl + '/user/signup'),
      headers: {"Content.type": "application/json"},
      body: body,
    );
    return response;
  }

  Future<dynamic> getSampleCrime() async {
    var response = await http.get(Uri.parse(baseUrl + '/user/crimeSample'));
    if (response.statusCode == 200) {
      List<dynamic> djson = jsonDecode(response.body);
      List<SampleCrime> sampleCrime =
          djson.map((json) => SampleCrime.fromJson(json)).toList();
      return sampleCrime;
    } else {
      throw Exception("Failed to get crime samples ");
    }
  }


  Future<dynamic> getStations() async {
    var response = await http.get(Uri.parse(baseUrl + '/police/get'));
    List<String> stations = [""];
    if (response.statusCode == 200) {
      (json.decode(response.body)).forEach((station) {
        stations.add(station["fullname"]);
      });
      return [stations, response];
    } else {
      throw Exception("Failed to find stations");
    }
  }

  Future postImage(
    String filepath,
  ) async {
    String? token = await storage.read(key: "token");
    var request =
        http.MultipartRequest("POST", Uri.parse(baseUrl + '/user/add/image'));
    request.files.add(await http.MultipartFile.fromPath("img", filepath));
    request.headers
        .addAll({"Content.type": "multipart/form.data", "token": "$token"});
    http.StreamedResponse response = await request.send();
    var httpResponse = await http.Response.fromStream(response);
    return httpResponse;
  }


  Future<dynamic> reportCrime(Map<String, dynamic> body) async {
    String? token = await storage.read(key: "token");
    var response = await http.post(
      Uri.parse(baseUrl + '/user/crime/report'),
      headers: {"Content.type": "application/json", "token": "$token"},
      body: body,
    );
    return response;
  }

  Future<dynamic> getMyReport(String user) async {
    var response = await http.get(
      Uri.parse(baseUrl + '/user/myreports/$user'),
      headers: {"Content.type": "application/json"},
    );
    return response;
  }



  Future updateProfileImage(String filepath, String email) async {
    String? token = await storage.read(key: "token");
    var request = http.MultipartRequest(
        "POST", Uri.parse(baseUrl + '/profile/update/image/$email'));

      request.files.add(await http.MultipartFile.fromPath("img", filepath));
      request.headers
        .addAll({"Content.type": "multipart/form.data", "token": "$token"});
    http.StreamedResponse response = await request.send();
    var httpResponse = await http.Response.fromStream(response);
    return httpResponse;
  }


  Future<dynamic> updateProfile(dynamic email, dynamic phoneNo,
      dynamic password, dynamic fullname) async {
    var response = await http
        .patch(Uri.parse(baseUrl + '/profile/update/profile'), headers: {
      "Content.type": "application/json"
    }, body: {
      "email": email,
      "password": password,
      "phoneNo": phoneNo,
      "fullname": fullname
    });

    return response;
  }

  Future<dynamic> deleteReported(id) async {
    var response = await http.get(
      Uri.parse(baseUrl + '/police/crime/delete/$id'),
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception("Failed to get crime");
    }
  }
}
