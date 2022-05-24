
import 'dart:convert';
import 'package:crime_reporter/models/report.dart';
import 'package:crime_reporter/models/samplecrimes.dart';
import 'package:crime_reporter/models/user.dart';

class Api {
    
    dynamic getUser (String jeson){
            dynamic json = jsonDecode(jeson);
            dynamic user = User.fromJson(json['user']);
            return user;
           
          }


    dynamic getSampleCrime(jeson){
        List <dynamic> djson = jsonDecode(jeson);
        List <SampleCrime> sampleCrime = djson.map((json)=>SampleCrime.fromJson(json)).toList();
        return sampleCrime;
           
        }
 
     dynamic getReportedCrime(String jeson){
            dynamic json = jsonDecode(jeson);
            dynamic reportedCrime = Report.fromJson(json);
            return reportedCrime;
           
          }
  
}
