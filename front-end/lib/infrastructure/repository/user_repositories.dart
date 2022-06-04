import 'package:crime_reporter/infrastructure/data_provider/user_data_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

 class UserRepository {
  
    final UserDataProvider dataProvider= UserDataProvider();
      static const storage =  FlutterSecureStorage();

    Future<void> deleteToken() async {
      return await storage.deleteAll();
     }
    
    Future<bool> hasToken() async {
       String? token = await storage.read(key:"token");
      return token != null;
     }
    
    Future<dynamic>? getUser(dynamic password, dynamic username) async {
    return dataProvider.getUser(password,username);
    }

    Future<dynamic> getSampleCrime() async {
    return dataProvider.getSampleCrime();
    }
    Future<dynamic> getStations() async {
    return dataProvider.getStations();
    }

     Future<dynamic> postImage(path) async {
    return dataProvider.postImage(path);
    }
    Future<dynamic> reportCrime(Map<String,dynamic> body) async {
    return dataProvider.reportCrime(body);
    }
    Future<dynamic> getMyReport(String id) async {
    return dataProvider.getMyReport(id);
    }

    Future<dynamic> signUpUser(Map<String,dynamic> body) async {
    return dataProvider.signUpUser(body);
    }

    
     Future<dynamic> updateProfileImage(dynamic path ,dynamic email) async {
    return dataProvider.updateProfileImage(path,email);
    }

    Future<dynamic> updateProfile(
      dynamic email ,dynamic phoneNo , dynamic password , dynamic fullname) async {
      return dataProvider.updateProfile(email,phoneNo,password,fullname);
    }

     Future<dynamic> deleteReported(id) async {
    return dataProvider.deleteReported(id);
    }
}