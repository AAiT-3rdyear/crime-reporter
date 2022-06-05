import 'package:crime_reporter/application/Auth/Bloc/Auth_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoginEvent', () {
    group('LoginSubmitted', () {
      test('supports value comparisons', () {
        expect(LogingIn(), LogingIn());
      });
    });
  });
}
