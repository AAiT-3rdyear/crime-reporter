import 'package:crime_reporter/application/user/bloc/userbloc_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('userblocevent', () {
    group('Userbloc', () {
      test('supports value equality', () {
        expect(UserblocBloc().state, UserblocInitial());
      });
    });
  });
}
