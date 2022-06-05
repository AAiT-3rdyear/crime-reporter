import 'package:crime_reporter/bloc/userBloc/userbloc_bloc.dart';
import 'package:crime_reporter/repositories/user_repositories.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../lib/bloc/authBloc/auth_bloc.dart';

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
