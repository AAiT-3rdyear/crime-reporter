import 'package:crime_reporter/application/user/bloc/userbloc_bloc.dart';
import 'package:crime_reporter/infrastructure/repository/user_repositories.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late UserRepository userRepository;
  group('userbloc', () {
    test('supports value comparisons', () {
      expect(UserblocInitial(), UserblocInitial());
    });

    test("returns same object when no properties are passed", () {
      expect(UserblocInitial().props, []);
    });

      test("returns same object when no properties are passed", () {
      expect(SelectDateTimeFailed(), SelectDateTimeFailed());
    });
  });
}
