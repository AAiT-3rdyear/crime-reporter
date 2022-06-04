import 'package:crime_reporter/infrastructure/data_provider/police_data_provider.dart';

 class PoliceRepository {
  
    final PoliceDataProvider dataProvider= PoliceDataProvider();

    Future<dynamic> getReportedCrimes(user) async {
    return dataProvider.getReportedCrime(user);
    }
    
    Future<dynamic> getOngoingCrimes(user) async {
    return dataProvider.getOngoingCrimes(user);
    }
    Future<dynamic> getSolvedCrimes(user) async {
    return dataProvider.getSolvedCrimes(user);
    }

    Future<dynamic> deleteCrime(id) async {
    return dataProvider.deleteCrime(id);
    }

    Future<dynamic> moveToOngoing(id) async {
    return dataProvider.moveToOngoing(id);
    }

     Future<dynamic> moveToSolved(id) async {
    return dataProvider.moveToSolved(id);
    }
}