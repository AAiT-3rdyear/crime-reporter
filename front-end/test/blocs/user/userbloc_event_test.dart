import 'package:crime_reporter/bloc/userBloc/userbloc_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../lib/bloc/authBloc/auth_bloc.dart';

void main() {
  group('userblocevent', () {
    group('Userbloc', () {
      test('supports value equality', () {
        expect(UserblocBloc().state, UserblocInitial());
      });
    });
  });
}
