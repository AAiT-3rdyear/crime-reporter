import 'package:crime_reporter/infrastructure/data_provider/user_data_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:crime_reporter/infrastructure/repository/user_repositories.dart';
import 'package:crime_reporter/domain/User_models/user.dart';

import 'user_repository_test.mocks.dart';

class UserRepoTest extends Mock implements UserDataProvider {}

@GenerateMocks([UserRepoTest])
Future<void> main() async {
  late MockUserRepoTest userRepo;

  setUpAll(() {
    userRepo = MockUserRepoTest();
  });

  group('user repo test', () {
    test('test fetchData', () async {
      final model = User(
          userId: '1',
          email: 'abi@gmail.com',
          fullname: 'abel mokonnen',
          imgUrl: '../assets/crimeImages/genocide.jpg',
          password: '12345',
          phoneNo: '0926284282',
          role: 'user');

      when(userRepo.getMyReport("user")).thenAnswer((_) async {
        return model;
      });

      final res = await userRepo.getMyReport("user");

      expect(res, isA<User>());
      expect(res, model);
    });

    test('test getMyreports throws Exception', () {
      when(userRepo.getMyReport("user")).thenAnswer((_) async {
        throw Exception();
      });

      final res = userRepo.getMyReport("user");

      expect(res, throwsException);
    });
  });
}
