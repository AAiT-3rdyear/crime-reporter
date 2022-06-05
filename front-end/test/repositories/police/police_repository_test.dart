import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:crime_reporter/infrastructure/data_provider/police_data_provider.dart';
import 'package:crime_reporter/infrastructure/repository/police_repositories.dart';
import 'police_repository_test.mocks.dart';

class PoliceRepoTest extends Mock implements PoliceDataProvider {}

@GenerateMocks([PoliceRepoTest])
Future<void> main() async {
  late MockPoliceRepoTest policeRepo;

  setUpAll(() {
    policeRepo = MockPoliceRepoTest();
  });

  group('user repo test', () {
    test('test getreportedcrimes', () async {
      final model = PoliceDataProvider();
      when(policeRepo.getReportedCrime("crime")).thenAnswer((_) async {
        return model;
      });

      final res = await policeRepo.getReportedCrime("crime");

      expect(res, isA<PoliceDataProvider>());
      expect(res, model);
    });

    test('test getReportedcrimes throws Exception', () {
      when(policeRepo.getReportedCrime("crime")).thenAnswer((_) async {
        throw Exception();
      });

      final res = policeRepo.getReportedCrime("crime");

      expect(res, throwsException);
    });

    test('test movetoongoingcrimes', () async {
      final model = PoliceDataProvider();
      when(policeRepo.moveToOngoing("id")).thenAnswer((_) async {
        return model;
      });

      final res = await policeRepo.moveToOngoing("id");

      expect(res, isA<PoliceDataProvider>());
      expect(res, model);
    });

    test('test movetoOngoing throws Exception', () {
      when(policeRepo.moveToOngoing("id")).thenAnswer((_) async {
        throw Exception();
      });

      final res = policeRepo.moveToOngoing("id");

      expect(res, throwsException);
    });
    test('test movetoongoingcrimes', () async {
      final model = PoliceDataProvider();
      when(policeRepo.moveToSolved("id")).thenAnswer((_) async {
        return model;
      });

      final res = await policeRepo.moveToSolved("id");

      expect(res, isA<PoliceDataProvider>());
      expect(res, model);
    });

    test('test movetosolved throws Exception', () {
      when(policeRepo.moveToSolved("id")).thenAnswer((_) async {
        throw Exception();
      });

      final res = policeRepo.moveToSolved("id");

      expect(res, throwsException);
    });
  });
}
